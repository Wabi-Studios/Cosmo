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

struct NavigateCommands: Commands
{
  var body: some Commands
  {
    CommandMenu("Navigate")
    {
      Group
      {
        Button("Reveal in Project Navigator")
        {}
        .keyboardShortcut("j", modifiers: [.shift, .command])

        Button("Reveal Changes in Navigator")
        {}
        .keyboardShortcut("m", modifiers: [.shift, .command])

        Button("Open in Next Editor")
        {}
        .keyboardShortcut(",", modifiers: [.option, .command])

        Button("Open in...")
        {}

        Divider()

        Button("Show Previous Tab")
        {}

        Button("Show Next Tab")
        {}

        Divider()

        Button("Go Forward")
        {}
      }
      .disabled(true)

      Group
      {
        Button("Go Back")
        {}

        Divider()

        Button("Jump to Selection")
        {}
        .keyboardShortcut("l", modifiers: [.command, .option])

        Button("Jump to Definition")
        {}
        .keyboardShortcut("j")

        Button("Jump to Original Source")
        {}

        Button("Jump to Last Destination")
        {}

        Divider()

        Button("Jump to Next Issue")
        {}
        .keyboardShortcut("'")

        Button("Jump to Previous Issue")
        {}
        .keyboardShortcut("\"")
      }
      .disabled(true)
    }
  }
}
