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

import SwiftUI

struct SplitEditorEnvironmentKey: EnvironmentKey
{
  static var defaultValue: (Edge, TabGroupData) -> Void = { _, _ in }
}

extension EnvironmentValues
{
  var splitEditor: SplitEditorEnvironmentKey.Value
  {
    get { self[SplitEditorEnvironmentKey.self] }
    set { self[SplitEditorEnvironmentKey.self] = newValue }
  }
}
