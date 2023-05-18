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

/// Enum to represent item's ID to tab bar
enum TabBarItemID: Codable, Identifiable, Hashable
{
  var id: String
  {
    switch self
    {
      case let .codeEditor(path):
        return "codeEditor_\(path)"
      case let .extensionInstallation(id):
        return "extensionInstallation_\(id.uuidString)"
    }
  }

  /// Represents code editor tab
  case codeEditor(String)

  /// Represents extension installation tab
  case extensionInstallation(UUID)
}
