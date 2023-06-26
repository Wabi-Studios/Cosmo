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

/// A collection of types describing possible tabs in the Status Bar.
enum StatusBarTabType: String, CaseIterable, Identifiable
{
  case terminal
  case debugger
  case output

  var id: String { rawValue }
  static var allOptions: [String]
  {
    StatusBarTabType.allCases.map(\.rawValue.capitalized)
  }
}
