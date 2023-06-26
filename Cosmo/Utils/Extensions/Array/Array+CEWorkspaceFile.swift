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

extension [CEWorkspaceFile]
{
  /// Sorts the elements in alphabetical order.
  /// - Parameter foldersOnTop: if set to `true` folders will always be on top of files.
  /// - Returns: A sorted array of ``FileSystemClient/FileSystemClient/FileItem``
  func sortItems(foldersOnTop: Bool) -> Self
  {
    var alphabetically = sorted { $0.name < $1.name }

    if foldersOnTop
    {
      var foldersOnTop = alphabetically.filter { $0.children != nil }
      alphabetically.removeAll { $0.children != nil }

      foldersOnTop.append(contentsOf: alphabetically)

      return foldersOnTop
    }
    else
    {
      return alphabetically
    }
  }
}

extension Array where Element: Hashable
{
  /// Checks the difference between two given items.
  /// - Parameter other: Other element
  /// - Returns: symmetricDifference
  func difference(from other: [Element]) -> [Element]
  {
    let thisSet = Set(self)
    let otherSet = Set(other)
    return Array(thisSet.symmetricDifference(otherSet))
  }
}
