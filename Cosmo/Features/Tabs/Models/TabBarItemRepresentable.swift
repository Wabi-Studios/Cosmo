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

import SwiftUI

/// Protocol for data passed to TabBarItemView to conform to
protocol TabBarItemRepresentable
{
  /// Unique tab identifier
  var tabID: TabBarItemID { get }
  /// String to be shown as tab's title
  var name: String { get }
  /// Image to be shown as tab's icon
  var icon: Image { get }
  /// Color of the tab's icon
  var iconColor: Color { get }
}
