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

struct FileCommands: Commands
{
  var body: some Commands
  {
    CommandGroup(replacing: .newItem)
    {
      Group
      {
        Button("New")
        {
          NSDocumentController.shared.newDocument(nil)
        }
        .keyboardShortcut("n")

        Button("Open...")
        {
          NSDocumentController.shared.openDocument(nil)
        }
        .keyboardShortcut("o")

        // Leave this empty, is done through a hidden API in WindowCommands/Utils/CommandsFixes.swift
        // This can't be done in SwiftUI Commands yet, as they don't support images in menu items.
        Menu("Open Recent") {}

        Button("Open Quickly")
        {
          NSApp.sendAction(#selector(CosmoWindowController.openQuickly(_:)), to: nil, from: nil)
        }
        .keyboardShortcut("o", modifiers: [.command, .shift])
      }
    }

    CommandGroup(replacing: .saveItem)
    {
      Button("Close Tab")
      {
        NSApp.sendAction(#selector(NSWindow.close), to: nil, from: nil)
      }
      .keyboardShortcut("w")

      Button("Close Editor")
      {}
      .keyboardShortcut("w", modifiers: [.control, .shift, .command])

      Button("Close Window")
      {}
      .keyboardShortcut("w", modifiers: [.shift, .command])

      Button("Close Workspace")
      {}
      .keyboardShortcut("w", modifiers: [.control, .option, .command])

      Divider()

      Button("Save")
      {
        NSApp.sendAction(#selector(CosmoWindowController.saveDocument(_:)), to: nil, from: nil)
      }
      .keyboardShortcut("s")
    }
  }
}
