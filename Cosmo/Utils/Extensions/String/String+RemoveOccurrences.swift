/* -----------------------------------------------------------
 * :: :  C  O  S  M  O  :                                ::
 * -----------------------------------------------------------
 * @wabistudios :: cosmo :: composer
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

extension String
{
  /// Removes all `new-line` characters in a `String`
  /// - Returns: A String
  func removingNewLines() -> String
  {
    replacingOccurrences(of: "\n", with: "")
  }

  /// Removes all `space` characters in a `String`
  /// - Returns: A String
  func removingSpaces() -> String
  {
    replacingOccurrences(of: " ", with: "")
  }
}
