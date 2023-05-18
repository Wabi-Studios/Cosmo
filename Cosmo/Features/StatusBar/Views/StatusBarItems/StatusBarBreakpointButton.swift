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

import CodeEditSymbols
import SwiftUI

struct StatusBarBreakpointButton: View
{
  @EnvironmentObject
  private var model: StatusBarViewModel

  var body: some View
  {
    Button
    {
      model.isBreakpointEnabled.toggle()
    } label: {
      if model.isBreakpointEnabled
      {
        Image.breakpoint_fill
          .foregroundColor(.accentColor)
      }
      else
      {
        Image.breakpoint
          .foregroundColor(.secondary)
      }
    }
    .buttonStyle(.plain)
  }
}
