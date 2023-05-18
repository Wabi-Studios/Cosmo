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

struct ActiveTabGroupEnvironmentKey: EnvironmentKey
{
  static var defaultValue = false
}

extension EnvironmentValues
{
  var isActiveTabGroup: Bool
  {
    get { self[ActiveTabGroupEnvironmentKey.self] }
    set { self[ActiveTabGroupEnvironmentKey.self] = newValue }
  }
}
