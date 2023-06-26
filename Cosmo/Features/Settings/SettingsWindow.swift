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

struct SettingsWindow: Scene
{
  private let updater = SoftwareUpdater()

  var body: some Scene
  {
    Window("Settings", id: "settings")
    {
      SettingsView(updater: updater)
        .frame(minWidth: 715, maxWidth: 715)
        .task
        {
          let window = NSApp.windows.first { $0.identifier?.rawValue == "settings" }!
          window.titlebarAppearsTransparent = true
        }
    }
    .windowStyle(.automatic)
    .windowToolbarStyle(.unified)
    .windowResizability(.contentSize)
  }
}
