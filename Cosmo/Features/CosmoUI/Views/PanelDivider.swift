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

struct PanelDivider: View
{
  @Environment(\.colorScheme)
  private var colorScheme

  var body: some View
  {
    Divider()
      .opacity(0)
      .overlay(
        Color(.black)
          .opacity(colorScheme == .dark ? 0.65 : 0.13)
      )
  }
}
