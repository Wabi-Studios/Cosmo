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

/// # Project Navigator - Sidebar
///
/// A list that functions as a project navigator, showing collapsible folders
/// and files.
///
/// When selecting a file it will open in the editor.
///
struct ProjectNavigatorView: View
{
  @EnvironmentObject var tabManager: TabManager

  var body: some View
  {
    ProjectNavigatorOutlineView(selection: $tabManager.activeTabGroup.selected)
      .safeAreaInset(edge: .bottom, spacing: 0)
      {
        ProjectNavigatorToolbarBottom()
      }
  }
}
