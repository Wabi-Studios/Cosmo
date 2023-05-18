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

import SwiftUI

struct SourceControlCommands: Commands
{
  var body: some Commands
  {
    CommandMenu("Source Control")
    {
      Group
      {
        Button("Commit...")
        {}
        .keyboardShortcut("c", modifiers: [.option, .command])

        Button("Push...")
        {}

        Button("Pull...")
        {}
        .keyboardShortcut("x", modifiers: [.option, .command])

        Button("Fetch Changes")
        {}

        Button("Refresh File Status")
        {}

        Divider()

        Button("Cherry-Pick...")
        {}

        Button("Stash changes...")
        {}

        Button("Discard All Changes...")
        {}

        Divider()
      }
      .disabled(true)

      Group
      {
        Button("Create Pull Request...")
        {}

        Divider()

        Button("Add Selected Files")
        {}

        Button("Discard Changes in Selected Files...")
        {}

        Button("Mark Selected Files as Resolved")
        {}

        Divider()

        Button("New Git Repositories")
        {}

        Divider()

        Button("Clone...")
        {}
      }
      .disabled(true)
    }
  }
}
