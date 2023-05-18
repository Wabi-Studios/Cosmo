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

struct StatusBarSplitTerminalButton: View
{
  @EnvironmentObject
  private var model: StatusBarViewModel

  var body: some View
  {
    Button
    {
      // todo
    } label: {
      Image(systemName: "square.split.2x1")
        .foregroundColor(.secondary)
    }
    .buttonStyle(.plain)
  }
}
