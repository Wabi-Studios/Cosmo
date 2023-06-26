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

struct NSWindowEnvironmentKey: EnvironmentKey
{
  static var defaultValue = NSWindow()
}

extension EnvironmentValues
{
  var window: NSWindowEnvironmentKey.Value
  {
    get { self[NSWindowEnvironmentKey.self] }
    set { self[NSWindowEnvironmentKey.self] = newValue }
  }
}
