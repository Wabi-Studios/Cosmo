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

struct NavigatorSidebarView: View
{
  @ObservedObject
  private var workspace: WorkspaceDocument

  @State
  private var selection: Int = 0

  init(workspace: WorkspaceDocument)
  {
    self.workspace = workspace
  }

  @AppSettings(\.general.navigatorTabBarPosition) var sidebarPosition: SettingsData.SidebarTabBarPosition

  var body: some View
  {
    VStack
    {
      switch selection
      {
        case 0:
          ProjectNavigatorView()
        case 1:
          SourceControlNavigatorView()
        case 2:
          FindNavigatorView()
        default:
          Spacer()
      }
    }
    .safeAreaInset(edge: .leading, spacing: 0)
    {
      if sidebarPosition == .side
      {
        NavigatorSidebarTabBar(selection: $selection, position: sidebarPosition)
      }
    }
    .safeAreaInset(edge: .top, spacing: 0)
    {
      if sidebarPosition == .top
      {
        NavigatorSidebarTabBar(selection: $selection, position: sidebarPosition)
      }
      else
      {
        Divider()
      }
    }
    .environmentObject(workspace)
  }
}
