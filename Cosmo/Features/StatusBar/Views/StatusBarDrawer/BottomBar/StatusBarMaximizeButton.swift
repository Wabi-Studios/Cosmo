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

struct StatusBarMaximizeButton: View
{
  @EnvironmentObject
  private var model: StatusBarViewModel

  var body: some View
  {
    Button
    {
      model.isMaximized.toggle()
    } label: {
      Image(systemName: "arrowtriangle.up.square")
        .foregroundColor(model.isMaximized ? .accentColor : .secondary)
    }
    .buttonStyle(.plain)
  }
}
