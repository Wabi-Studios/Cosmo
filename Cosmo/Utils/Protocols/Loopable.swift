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

/// Loopable protocol implements a method that will return all child
/// properties and their associated values of a `Type`
protocol Loopable
{
  func allProperties() throws -> [String: Any]
}

extension Loopable
{
  /// returns all child properties and their associated values of `self`
  ///
  /// **Example:**
  /// ```swift
  /// struct Author: Loopable {
  ///   var name: String = "Steve"
  ///   var books: Int = 4
  /// }
  ///
  /// let author = Author()
  /// print(author.allProperties())
  ///
  /// // returns
  /// ["name": "Steve", "books": 4]
  /// ```
  func allProperties() throws -> [String: Any]
  {
    var result: [String: Any] = [:]

    let mirror = Mirror(reflecting: self)

    guard let style = mirror.displayStyle, style == .struct || style == .class
    else
    {
      // TODO: Throw a proper error
      throw NSError() // swiftlint:disable:this discouraged_direct_init
    }

    for (property, value) in mirror.children
    {
      guard let property
      else
      {
        continue
      }

      result[property] = value
    }

    return result
  }
}
