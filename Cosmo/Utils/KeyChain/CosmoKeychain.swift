/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                   ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmos :: realms
 *
 * CREDITS.
 *
 * T.Furby              @furby-tm       <devs@wabi.foundation>
 *
 *         Copyright (C) 2023 Wabi Animation Studios, Ltd. Co.
 *                                        All Rights Reserved.
 * -----------------------------------------------------------
 *  . x x x . o o o . x x x . : : : .    o  x  o    . : : : .
 * ----------------------------------------------------------- */

import Foundation
import Security

// TODO: DOCS (Nanashi Li)
class CosmoKeychain
{
  var lastQueryParameters: [String: Any]? // Used by the unit tests

  /// Contains result code from the last operation. Value is noErr (0) for a successful result.
  var lastResultCode: OSStatus = noErr

  var keyPrefix = "" // Can be useful in test.

  /**
   Specify an access group that will be used to access keychain items.
   Access groups can be used to share keychain items between applications.
   When access group value is nil all application access groups are being accessed.
   Access group name is used by all functions: set, get, delete and clear.
   */
  var accessGroup: String?

  private let lock = NSLock()

  init() {}

  /**
   - parameter keyPrefix: a prefix that is added before the key in get/set methods.
   Note that `clear` method still clears everything from the Keychain.
   */
  init(keyPrefix: String)
  {
    self.keyPrefix = keyPrefix
  }

  /**
   Stores the text value in the keychain item under the given key.
   - parameter key: Key under which the text value is stored in the keychain.
   - parameter value: Text string to be written to the keychain.
   - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item.
   By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed only
   while the device is unlocked by the user.
   - returns: True if the text was successfully written to the keychain.
   */
  @discardableResult
  func set(
    _ value: String,
    forKey key: String,
    withAccess access: CosmoKeychainAccessOptions? = nil
  ) -> Bool
  {
    if let value = value.data(using: String.Encoding.utf8)
    {
      return set(value, forKey: key, withAccess: access)
    }
    return false
  }

  /**
   Stores the data in the keychain item under the given key.
   - parameter key: Key under which the data is stored in the keychain.
   - parameter value: Data to be written to the keychain.
   - parameter withAccess: Value that indicates when your app needs access to the text in the keychain item.
   By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed
   only while the device is unlocked by the user.
   - returns: True if the text was successfully written to the keychain.
   */
  @discardableResult
  func set(
    _ value: Data,
    forKey key: String,
    withAccess access: CosmoKeychainAccessOptions? = nil
  ) -> Bool
  {
    // The lock prevents the code to be run simultaneously
    // from multiple threads which may result in crashing
    lock.lock()
    defer { lock.unlock() }

    deleteNoLock(key) // Delete any existing key before saving it
    let accessible = access?.value ?? CosmoKeychainAccessOptions.defaultOption.value

    let prefixedKey = keyWithPrefix(key)

    var query: [String: Any] = [
      CosmoKeychainConstants.class: kSecClassGenericPassword,
      CosmoKeychainConstants.attrAccount: prefixedKey,
      CosmoKeychainConstants.valueData: value,
      CosmoKeychainConstants.accessible: accessible,
    ]

    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query

    lastResultCode = SecItemAdd(query as CFDictionary, nil)

    return lastResultCode == noErr
  }

  /**
   Stores the boolean value in the keychain item under the given key.
   - parameter key: Key under which the value is stored in the keychain.
   - parameter value: Boolean to be written to the keychain.
   - parameter withAccess: Value that indicates when your app needs access to the value in the keychain item.
   By default the .AccessibleWhenUnlocked option is used that permits the data to be accessed
   only while the device is unlocked by the user.
   - returns: True if the value was successfully written to the keychain.
   */
  @discardableResult
  func set(
    _ value: Bool,
    forKey key: String,
    withAccess access: CosmoKeychainAccessOptions? = nil
  ) -> Bool
  {
    let bytes: [UInt8] = value ? [1] : [0]
    let data = Data(bytes)

    return set(data, forKey: key, withAccess: access)
  }

  /**
   Retrieves the text value from the keychain that corresponds to the given key.
   - parameter key: The key that is used to read the keychain item.
   - returns: The text value from the keychain. Returns nil if unable to read the item.
   */
  func get(_ key: String) -> String?
  {
    if let data = getData(key)
    {
      if let currentString = String(data: data, encoding: .utf8)
      {
        return currentString
      }

      lastResultCode = -67853 // errSecInvalidEncoding
    }

    return nil
  }

  /**
   Retrieves the data from the keychain that corresponds to the given key.
   - parameter key: The key that is used to read the keychain item.
   - parameter asReference: If true, returns the data as reference (needed for things like NEVPNProtocol).
   - returns: The text value from the keychain. Returns nil if unable to read the item.
   */
  func getData(_ key: String, asReference: Bool = false) -> Data?
  {
    // The lock prevents the code to be run simultaneously
    // from multiple threads which may result in crashing
    lock.lock()
    defer { lock.unlock() }

    let prefixedKey = keyWithPrefix(key)

    var query: [String: Any] = [
      CosmoKeychainConstants.class: kSecClassGenericPassword,
      CosmoKeychainConstants.attrAccount: prefixedKey,
      CosmoKeychainConstants.matchLimit: kSecMatchLimitOne,
    ]

    if asReference
    {
      query[CosmoKeychainConstants.returnReference] = kCFBooleanTrue
    }
    else
    {
      query[CosmoKeychainConstants.returnData] = kCFBooleanTrue
    }

    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query

    var result: AnyObject?

    lastResultCode = withUnsafeMutablePointer(to: &result)
    {
      SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }

    if lastResultCode == noErr
    {
      return result as? Data
    }

    return nil
  }

  /**
   Retrieves the boolean value from the keychain that corresponds to the given key.
   - parameter key: The key that is used to read the keychain item.
   - returns: The boolean value from the keychain. Returns nil if unable to read the item.
   */
  func getBool(_ key: String) -> Bool?
  {
    guard let data = getData(key) else { return nil }
    guard let firstBit = data.first else { return nil }
    return firstBit == 1
  }

  /**
   Deletes the single keychain item specified by the key.
   - parameter key: The key that is used to delete the keychain item.
   - returns: True if the item was successfully deleted.
   */
  @discardableResult
  func delete(_ key: String) -> Bool
  {
    // The lock prevents the code to be run simultaneously
    // from multiple threads which may result in crashing
    lock.lock()
    defer { lock.unlock() }

    return deleteNoLock(key)
  }

  /**
   Return all keys from keychain
   - returns: An string array with all keys from the keychain.
   */
  var allKeys: [String]
  {
    var query: [String: Any] = [
      CosmoKeychainConstants.class: kSecClassGenericPassword,
      CosmoKeychainConstants.returnData: true,
      CosmoKeychainConstants.returnAttributes: true,
      CosmoKeychainConstants.returnReference: true,
      CosmoKeychainConstants.matchLimit: CosmoKeychainConstants.secMatchLimitAll,
    ]

    query = addAccessGroupWhenPresent(query)

    var result: AnyObject?

    let lastResultCode = withUnsafeMutablePointer(to: &result)
    {
      SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
    }

    if lastResultCode == noErr
    {
      return (result as? [[String: Any]])?.compactMap
      {
        $0[CosmoKeychainConstants.attrAccount] as? String
      } ?? []
    }

    return []
  }

  /**
   Same as `delete` but is only accessed internally, since it is not thread safe.
   - parameter key: The key that is used to delete the keychain item.
   - returns: True if the item was successfully deleted.
   */
  @discardableResult
  func deleteNoLock(_ key: String) -> Bool
  {
    let prefixedKey = keyWithPrefix(key)

    var query: [String: Any] = [
      CosmoKeychainConstants.class: kSecClassGenericPassword,
      CosmoKeychainConstants.attrAccount: prefixedKey,
    ]

    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query

    lastResultCode = SecItemDelete(query as CFDictionary)

    return lastResultCode == noErr
  }

  /**
   Deletes all Keychain items used by the app.
   Note that this method deletes all items regardless of the prefix settings used for initializing the class.
   - returns: True if the keychain items were successfully deleted.
   */
  @discardableResult
  func clear() -> Bool
  {
    // The lock prevents the code to be run simultaneously
    // from multiple threads which may result in crashing
    lock.lock()
    defer { lock.unlock() }

    var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
    query = addAccessGroupWhenPresent(query)
    lastQueryParameters = query

    lastResultCode = SecItemDelete(query as CFDictionary)

    return lastResultCode == noErr
  }

  /// Returns the key with currently set prefix.
  func keyWithPrefix(_ key: String) -> String
  {
    "\(keyPrefix)\(key)"
  }

  func addAccessGroupWhenPresent(_ items: [String: Any]) -> [String: Any]
  {
    guard let accessGroup else { return items }

    var result: [String: Any] = items
    result[CosmoKeychainConstants.accessGroup] = accessGroup
    return result
  }
}
