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

import Sparkle
import SwiftUI

struct MainCommands: Commands
{
  @Environment(\.openWindow) var openWindow

  var body: some Commands
  {
    CommandGroup(replacing: .appInfo)
    {
      Button("About Cosmo")
      {
        openWindow(id: SceneID.about.rawValue)
      }

      Button("Check for updates...")
      {
        NSApp.sendAction(#selector(SPUStandardUpdaterController.checkForUpdates(_:)), to: nil, from: nil)
      }
    }

    CommandGroup(replacing: .appSettings)
    {
      Button("Settings...")
      {
        openWindow(id: "settings")
      }
      .keyboardShortcut(",")
    }
  }
}
