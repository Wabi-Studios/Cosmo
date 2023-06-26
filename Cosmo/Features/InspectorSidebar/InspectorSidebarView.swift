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

struct InspectorSidebarView: View
{
  @ObservedObject
  private var workspace: WorkspaceDocument

  @EnvironmentObject
  private var tabManager: TabManager

  @State
  private var selection: Int = 0

  init(workspace: WorkspaceDocument)
  {
    self.workspace = workspace
  }

  @AppSettings(\.general.inspectorTabBarPosition) var sidebarPosition: SettingsData.SidebarTabBarPosition

  var body: some View
  {
    VStack
    {
      if let path = tabManager.activeTabGroup.selected?.fileDocument?.fileURL?.path(percentEncoded: false)
      {
        switch selection
        {
          case 0:
            FileInspectorView(
              workspaceURL: workspace.fileURL!,
              fileURL: path
            )
          case 1:
            HistoryInspectorView(
              workspaceURL: workspace.fileURL!,
              fileURL: path
            )
          case 2:
            QuickHelpInspectorView().padding(5)
          default:
            NoSelectionInspectorView()
        }
      }
      else
      {
        NoSelectionInspectorView()
      }
    }
    .clipShape(Rectangle())
    .frame(
      minWidth: CosmoWindowController.minSidebarWidth,
      idealWidth: 260,
      minHeight: 0,
      maxHeight: .infinity,
      alignment: .top
    )
    .safeAreaInset(edge: .trailing, spacing: 0)
    {
      if sidebarPosition == .side
      {
        InspectorSidebarTabBar(selection: $selection, position: sidebarPosition)
      }
    }
    .safeAreaInset(edge: .top, spacing: 0)
    {
      if sidebarPosition == .top
      {
        InspectorSidebarTabBar(selection: $selection, position: sidebarPosition)
      }
      else
      {
        Divider()
      }
    }
  }
}
