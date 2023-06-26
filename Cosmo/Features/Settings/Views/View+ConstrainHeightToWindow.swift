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

extension NSWindow
{
  var isSettingsWindow: Bool
  {
    identifier?.rawValue == "settings"
  }
}

extension NSApplication
{
  var settingsWindow: NSWindow?
  {
    NSApp.windows.first { $0.isSettingsWindow }
  }
}

extension View
{
  func constrainHeightToWindow() -> some View
  {
    modifier(ConstrainHeightToWindowViewModifier())
  }
}

struct ConstrainHeightToWindowViewModifier: ViewModifier
{
  @State var height: CGFloat = 100

  func body(content: Content) -> some View
  {
    content
      .frame(height: height - 100)
      .onReceive(NSApp.settingsWindow!.publisher(for: \.frame))
      { newValue in
        height = newValue.height
      }
  }
}
