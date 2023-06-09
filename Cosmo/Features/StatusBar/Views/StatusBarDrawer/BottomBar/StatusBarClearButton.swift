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

struct StatusBarClearButton: View
{
  @EnvironmentObject
  private var model: StatusBarViewModel

  var body: some View
  {
    Button
    {
      // Clear terminal
    } label: {
      Image(systemName: "trash")
        .foregroundColor(.secondary)
    }
    .buttonStyle(.plain)
  }
}
