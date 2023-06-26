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

struct ViewCommands: Commands
{
  @AppSettings(\.textEditing.font) var font

  @State var windowController: CosmoWindowController?

  private let documentController: CosmoDocumentController = .init()
  private let statusBarViewModel: StatusBarViewModel = .init()

  var navigatorCollapsed: Bool
  {
    windowController?.navigatorCollapsed ?? false
  }

  var inspectorCollapsed: Bool
  {
    windowController?.navigatorCollapsed ?? false
  }

  var body: some Commands
  {
    CommandGroup(after: .toolbar)
    {
      Button("Show Command Palette")
      {
        NSApp.sendAction(#selector(CosmoWindowController.openCommandPalette(_:)), to: nil, from: nil)
      }
      .keyboardShortcut("p", modifiers: [.shift, .command])

      Button("Increase font size")
      {
        if CosmoDocumentController.shared.documents.count > 1
        {
          font.size += 1
        }
        font.size += 1
      }
      .keyboardShortcut("+")

      Button("Decrease font size")
      {
        if CosmoDocumentController.shared.documents.count > 1
        {
          if !(font.size <= 1)
          {
            font.size -= 1
          }
        }
        if !(font.size <= 1)
        {
          font.size -= 1
        }
      }
      .keyboardShortcut("-")

      Button("Customize Toolbar...")
      {}
      .disabled(true)

      Divider()

      Button("\(navigatorCollapsed ? "Show" : "Hide") Navigator")
      {
        windowController?.toggleFirstPanel()
      }
      .disabled(windowController == nil)
      .keyboardShortcut("s", modifiers: [.control, .command])
      .onReceive(NSApp.publisher(for: \.keyWindow))
      { window in
        windowController = window?.windowController as? CosmoWindowController
      }

      Button("\(inspectorCollapsed ? "Show" : "Hide") Inspector")
      {
        windowController?.toggleLastPanel()
      }
      .disabled(windowController == nil)
      .keyboardShortcut("i", modifiers: [.control, .command])
    }
  }
}
