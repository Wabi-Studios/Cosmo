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

struct EdgeInsetsEnvironmentKey: EnvironmentKey
{
  static var defaultValue: EdgeInsets = .init(top: 1, leading: 0, bottom: 0, trailing: 0)
}

extension EnvironmentValues
{
  var edgeInsets: EdgeInsetsEnvironmentKey.Value
  {
    get { self[EdgeInsetsEnvironmentKey.self] }
    set { self[EdgeInsetsEnvironmentKey.self] = newValue }
  }
}

extension EdgeInsets
{
  var nsEdgeInsets: NSEdgeInsets
  {
    .init(top: top, left: leading, bottom: bottom, right: trailing)
  }
}
