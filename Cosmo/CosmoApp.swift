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

@main
struct CosmoApp: App
{
  @NSApplicationDelegateAdaptor var appdelegate: AppDelegate
  let updater: SoftwareUpdater = .init()

  init()
  {
    _ = CosmoDocumentController.shared
    NSMenuItem.swizzle()
    NSSplitViewItem.swizzle()
  }

  var body: some Scene
  {
    WelcomeWindow()

    AboutWindow()

    SettingsWindow()
      .commands
      {
        CosmoCommands()
      }
  }
}
