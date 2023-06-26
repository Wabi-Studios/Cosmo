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

private struct WorkspaceFullscreenStateEnvironmentKey: EnvironmentKey
{
  static let defaultValue: Bool = false
}

extension EnvironmentValues
{
  var isFullscreen: Bool
  {
    get { self[WorkspaceFullscreenStateEnvironmentKey.self] }
    set { self[WorkspaceFullscreenStateEnvironmentKey.self] = newValue }
  }
}
