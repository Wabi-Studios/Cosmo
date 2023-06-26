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

extension View
{
  func hideSidebarToggle() -> some View
  {
    modifier(HideSidebarToggleViewModifier())
  }
}

struct HideSidebarToggleViewModifier: ViewModifier
{
  func body(content: Content) -> some View
  {
    content
      .task
      {
        let window = NSApp.windows.first { $0.identifier?.rawValue == "settings" }!
        let sidebaritem = "com.apple.SwiftUI.navigationSplitView.toggleSidebar"
        let index = window.toolbar?.items.firstIndex { $0.itemIdentifier.rawValue == sidebaritem }
        if let index
        {
          window.toolbar?.removeItem(at: index)
        }
      }
  }
}
