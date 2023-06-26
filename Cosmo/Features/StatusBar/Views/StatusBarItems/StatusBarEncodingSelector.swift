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

struct StatusBarEncodingSelector: View
{
  var body: some View
  {
    Menu
    {
      // UTF 8, ASCII, ...
    } label: {
      Text("UTF 8")
    }
    .menuStyle(StatusBarMenuStyle())
    .onHover { isHovering($0) }
  }
}
