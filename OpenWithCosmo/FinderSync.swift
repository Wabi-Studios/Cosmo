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

/* 
 * For anyone working on this file.
 * print does not output to the console, use NSLog.
 * open "console.app" to debug,
 */

import Cocoa
import FinderSync
import os.log

class CEOpenWith: FIFinderSync
{
  let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "FinderSync")

  override init()
  {
    super.init()
    // Add finder sync
    let finderSync = FIFinderSyncController.default()
    if let mountedVolumes = FileManager.default.mountedVolumeURLs(
      includingResourceValuesForKeys: nil,
      options: [.skipHiddenVolumes]
    )
    {
      finderSync.directoryURLs = Set<URL>(mountedVolumes)
    }
    // Monitor volumes
    let notificationCenter = NSWorkspace.shared.notificationCenter
    notificationCenter.addObserver(
      forName: NSWorkspace.didMountNotification,
      object: nil,
      queue: .main
    )
    { notification in
      if let volumeURL = notification.userInfo?[NSWorkspace.volumeURLUserInfoKey] as? URL
      {
        finderSync.directoryURLs.insert(volumeURL)
      }
    }
  }

  /// Open in Cosmo (menu) action
  /// - Parameter sender: sender
  @objc func openInCosmoAction(_: AnyObject?)
  {
    guard let items = FIFinderSyncController.default().selectedItemURLs(),
          let defaults = UserDefaults(suiteName: "foundation.wabi.cosmo.shared")
    else
    {
      return
    }

    // Make values compatible to ArrayLiteralElement
    var files = ""

    for obj in items
    {
      files.append("\(obj.path);")
    }

    guard let cosmo = NSWorkspace.shared.urlForApplication(
      withBundleIdentifier: "foundation.wabi.cosmo"
    ) else { return }

    // Add files to open to openInCEFiles.
    defaults.set(files, forKey: "openInCEFiles")

    NSWorkspace.shared.open(
      [],
      withApplicationAt: cosmo,
      configuration: NSWorkspace.OpenConfiguration()
    )
  }

  // MARK: - Menu and toolbar item support

  override func menu(for _: FIMenuKind) -> NSMenu
  {
    guard let defaults = UserDefaults(suiteName: "foundation.wabi.cosmo.shared")
    else
    {
      logger.error("Unable to load defaults")
      return NSMenu(title: "")
    }

    // Register enableOpenInCE (enable Open In Cosmo
    defaults.register(defaults: ["enableOpenInCE": true])

    let menu = NSMenu(title: "")
    let menuItem = NSMenuItem(
      title: "Open in Cosmo",
      action: #selector(openInCosmoAction(_:)),
      keyEquivalent: ""
    )
    menuItem.image = NSImage(named: "icon")

    let enableOpenInCE = defaults.bool(forKey: "enableOpenInCE")
    logger.info("Enable Open In Cosmo value is \(enableOpenInCE, privacy: .public)")
    if enableOpenInCE
    {
      menu.addItem(menuItem)
    }
    return menu
  }
}
