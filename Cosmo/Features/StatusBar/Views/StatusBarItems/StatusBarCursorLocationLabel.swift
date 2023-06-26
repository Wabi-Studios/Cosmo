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

struct StatusBarCursorLocationLabel: View
{
  @Environment(\.controlActiveState)
  private var controlActive

  @EnvironmentObject
  private var model: StatusBarViewModel

  var body: some View
  {
    Text("Line: \(model.cursorLocation.line)  Col: \(model.cursorLocation.column)")
      .font(model.toolbarFont)
      .foregroundColor(foregroundColor)
      .fixedSize()
      .lineLimit(1)
      .onHover { isHovering($0) }
  }

  private var foregroundColor: Color
  {
    controlActive == .inactive ? Color(nsColor: .disabledControlTextColor) : Color(nsColor: .secondaryLabelColor)
  }
}
