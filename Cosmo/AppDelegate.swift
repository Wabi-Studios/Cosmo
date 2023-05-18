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

import CodeEditSymbols
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject
{
  private let updater = SoftwareUpdater()

  func applicationDidFinishLaunching(_: Notification)
  {
    enableWindowSizeSaveOnQuit()
    Settings.shared.preferences.general.appAppearance.applyAppearance()
    checkForFilesToOpen()

    NSApp.closeWindow(.welcome, .about)

    DispatchQueue.main.async
    {
      var needToHandleOpen = true

      // If no windows were reopened by NSQuitAlwaysKeepsWindows, do default behavior.
      // Non-WindowGroup SwiftUI Windows are still in NSApp.windows when they are closed,
      // So we need to think about those.
      if NSApp.windows.count > NSApp.openSwiftUIWindows
      {
        needToHandleOpen = false
      }

      for index in 0 ..< CommandLine.arguments.count
      {
        if CommandLine.arguments[index] == "--open", (index + 1) < CommandLine.arguments.count
        {
          let path = CommandLine.arguments[index + 1]
          let url = URL(fileURLWithPath: path)

          CosmoDocumentController.shared.reopenDocument(
            for: url,
            withContentsOf: url,
            display: true
          )
          { document, _, _ in
            document?.windowControllers.first?.synchronizeWindowTitleWithDocumentName()
          }

          needToHandleOpen = false
        }
      }

      if needToHandleOpen
      {
        self.handleOpen()
      }
    }
  }

  func applicationWillTerminate(_: Notification)
  {}

  func applicationSupportsSecureRestorableState(_: NSApplication) -> Bool
  {
    true
  }

  func applicationShouldHandleReopen(_: NSApplication, hasVisibleWindows flag: Bool) -> Bool
  {
    if flag
    {
      return false
    }

    handleOpen()

    return false
  }

  func applicationShouldOpenUntitledFile(_: NSApplication) -> Bool
  {
    false
  }

  func handleOpen()
  {
    let behavior = Settings.shared.preferences.general.reopenBehavior

    switch behavior
    {
      case .welcome:
        NSApp.openWindow(.welcome)
      case .openPanel:
        CosmoDocumentController.shared.openDocument(self)
      case .newDocument:
        CosmoDocumentController.shared.newDocument(self)
    }
  }

  /// Handle urls with the form `cosmo://file/{filepath}:{line}:{column}`
  func application(_: NSApplication, open urls: [URL])
  {
    for url in urls
    {
      let file = URL(fileURLWithPath: url.path).path.split(separator: ":")
      let filePath = URL(fileURLWithPath: String(file[0]))
      let line = file.count > 1 ? Int(file[1]) ?? 0 : 0
      let column = file.count > 2 ? Int(file[2]) ?? 1 : 1

      CosmoDocumentController.shared
        .openDocument(withContentsOf: filePath, display: true)
        { document, _, error in
          if let error
          {
            NSAlert(error: error).runModal()
            return
          }
          if line > 0, let document = document as? CodeFileDocument
          {
            document.cursorPosition = (line, column > 0 ? column : 1)
          }
        }
    }
  }

  func applicationShouldTerminate(_: NSApplication) -> NSApplication.TerminateReply
  {
    let projects: [String] = CosmoDocumentController.shared.documents
      .map
      { doc in
        (doc as? WorkspaceDocument)?.fileURL?.path
      }
      .filter { $0 != nil }
      .map { $0! }

    UserDefaults.standard.set(projects, forKey: AppDelegate.recoverWorkspacesKey)

    let areAllDocumentsClean = CosmoDocumentController.shared.documents.allSatisfy { !$0.isDocumentEdited }
    guard areAllDocumentsClean
    else
    {
      CosmoDocumentController.shared.closeAllDocuments(
        withDelegate: self,
        didCloseAllSelector: #selector(documentController(_:didCloseAll:contextInfo:)),
        contextInfo: nil
      )
      return .terminateLater
    }

    return .terminateNow
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool
  {
    false
  }

  // MARK: - Open windows

  @IBAction private func openWelcome(_: Any)
  {
    NSApp.openWindow(.welcome)
  }

  @IBAction private func openAbout(_: Any)
  {
    NSApp.openWindow(.about)
  }

  @IBAction func openFeedback(_: Any)
  {
    if tryFocusWindow(of: FeedbackView.self) { return }

    FeedbackView().showWindow()
  }

  @IBAction private func checkForUpdates(_: Any)
  {
    updater.checkForUpdates()
  }

  /// Tries to focus a window with specified view content type.
  /// - Parameter type: The type of viewContent which hosted in a window to be focused.
  /// - Returns: `true` if window exist and focused, otherwise - `false`
  private func tryFocusWindow<T: View>(of _: T.Type) -> Bool
  {
    guard let window = NSApp.windows.filter({ ($0.contentView as? NSHostingView<T>) != nil }).first
    else { return false }

    window.makeKeyAndOrderFront(self)
    return true
  }

  // MARK: - Open With Cosmo (Extension) functions

  private func checkForFilesToOpen()
  {
    guard let defaults = UserDefaults(
      suiteName: "foundation.wabi.cosmo.shared"
    )
    else
    {
      print("Failed to get/init shared defaults")
      return
    }

    // Register enableOpenInCE (enable Open In Cosmo
    defaults.register(defaults: ["enableOpenInCE": true])

    if let filesToOpen = defaults.string(forKey: "openInCEFiles")
    {
      let files = filesToOpen.split(separator: ";")

      for filePath in files
      {
        let fileURL = URL(fileURLWithPath: String(filePath))
        CosmoDocumentController.shared.reopenDocument(
          for: fileURL,
          withContentsOf: fileURL,
          display: true
        )
        { document, _, _ in
          document?.windowControllers.first?.synchronizeWindowTitleWithDocumentName()
        }
      }

      defaults.removeObject(forKey: "openInCEFiles")
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1)
    {
      self.checkForFilesToOpen()
    }
  }

  /// Enable window size restoring on app relaunch after quitting.
  private func enableWindowSizeSaveOnQuit()
  {
    // This enables window restoring on normal quit (instead of only on force-quit).
    UserDefaults.standard.setValue(true, forKey: "NSQuitAlwaysKeepsWindows")
  }

  // MARK: NSDocumentController delegate

  @objc func documentController(_: NSDocumentController, didCloseAll: Bool, contextInfo _: Any)
  {
    NSApplication.shared.reply(toApplicationShouldTerminate: didCloseAll)
  }
}

extension AppDelegate
{
  static let recoverWorkspacesKey = "recover.workspaces"
}
