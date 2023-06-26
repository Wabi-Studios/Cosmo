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

struct SourceControlToolbarBottom: View
{
  var body: some View
  {
    HStack(spacing: 0)
    {
      sourceControlMenu
      SourceControlSearchToolbar()
    }
    .frame(height: 29, alignment: .center)
    .frame(maxWidth: .infinity)
    .padding(.horizontal, 4)
    .overlay(alignment: .top)
    {
      Divider()
    }
  }

  private var sourceControlMenu: some View
  {
    Menu
    {
      Button("Discard Changes...") {}
        .disabled(true) // TODO: Implementation Needed
      Button("Stash Changes...") {}
        .disabled(true) // TODO: Implementation Needed
      Button("Commit...") {}
        .disabled(true) // TODO: Implementation Needed
      Button("Create Pull Request...") {}
        .disabled(true) // TODO: Implementation Needed
    } label: {
      Image(systemName: "ellipsis.circle")
    }
    .menuStyle(.borderlessButton)
    .menuIndicator(.hidden)
    .frame(maxWidth: 30)
  }
}
