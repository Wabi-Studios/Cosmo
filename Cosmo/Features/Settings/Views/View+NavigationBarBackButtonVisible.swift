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

struct NavigationBarBackButtonVisible: ViewModifier
{
  @Environment(\.presentationMode) var presentationMode
  @EnvironmentObject var model: SettingsViewModel

  func body(content: Content) -> some View
  {
    content
      .toolbar
      {
        ToolbarItem(placement: .navigation)
        {
          Button
          {
            print(presentationMode.wrappedValue)
            presentationMode.wrappedValue.dismiss()
          } label: {
            Image(systemName: "chevron.left")
          }
        }
      }
      .hideSidebarToggle()
      .onAppear
      {
        model.backButtonVisible = true
      }
  }
}

extension View
{
  func navigationBarBackButtonVisible() -> some View
  {
    modifier(NavigationBarBackButtonVisible())
  }
}
