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

struct WelcomeWindow: Scene
{
  @ObservedObject var settings = Settings.shared

  var body: some Scene
  {
    Window("Welcome To Cosmo", id: SceneID.welcome.rawValue)
    {
      ContentView()
        .frame(width: 795, height: 460)
        .task
        {
          if let window = NSApp.findWindow(.welcome)
          {
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.isMovableByWindowBackground = true
          }
        }
        .environment(\.settings, settings.preferences)
    }
    .windowStyle(.hiddenTitleBar)
    .keyboardShortcut("1", modifiers: [.command, .shift])
    .windowResizability(.contentSize)
  }

  struct ContentView: View
  {
    @Environment(\.dismiss) var dismiss
    @Environment(\.openWindow) var openWindow

    var body: some View
    {
      WelcomeWindowView(shellClient: currentWorld.shellClient)
      { url, opened in
        if let url
        {
          CosmoDocumentController.shared.openDocument(withContentsOf: url, display: true)
          { doc, _, _ in
            if doc != nil
            {
              opened()
            }
          }
        }
        else
        {
          dismiss()
          CosmoDocumentController.shared.openDocument(
            onCompletion: { _, _ in opened() },
            onCancel: { openWindow(id: "Welcome") }
          )
        }
      } newDocument: {
        CosmoDocumentController.shared.newDocument(nil)
      } dismissWindow: {
        dismiss()
      }
    }
  }
}
