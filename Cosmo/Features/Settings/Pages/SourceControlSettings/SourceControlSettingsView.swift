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

struct SourceControlSettingsView: View
{
  @State var selectedTab: String = "general"

  var body: some View
  {
    Group
    {
      switch selectedTab
      {
        case "general":
          SourceControlGeneralView()
        case "git":
          SourceControlGitView()
        default:
          SourceControlGeneralView()
      }
    }
    .safeAreaInset(edge: .top, spacing: 0)
    {
      Picker("", selection: $selectedTab)
      {
        Text("General").tag("general")
        Text("Git").tag("git")
      }
      .pickerStyle(.segmented)
      .labelsHidden()
      .padding(.horizontal, 20)
      .padding(.bottom, 20)
    }
  }
}
