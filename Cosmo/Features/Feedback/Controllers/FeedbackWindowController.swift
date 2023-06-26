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

final class FeedbackWindowController: NSWindowController, NSToolbarDelegate
{
  convenience init(view: some View, size: NSSize)
  {
    let hostingController = NSHostingController(rootView: SettingsInjector { view })
    let window = NSWindow(contentViewController: hostingController)
    self.init(window: window)
    window.title = "Feedback for Cosmo"
    window.setContentSize(size)
    window.styleMask.insert(.fullSizeContentView)
    window.styleMask.remove(.resizable)
  }

  override func showWindow(_ sender: Any?)
  {
    window?.center()
    window?.alphaValue = 0.0

    super.showWindow(sender)

    window?.animator().alphaValue = 1.0

    window?.collectionBehavior = [.transient, .ignoresCycle]
    window?.backgroundColor = .windowBackgroundColor

    feedbackToolbar()
  }

  private func feedbackToolbar()
  {
    let toolbar = NSToolbar(identifier: UUID().uuidString)
    toolbar.delegate = self
    toolbar.displayMode = .labelOnly
    window?.toolbarStyle = .unifiedCompact
    window?.toolbar = toolbar
  }

  func closeAnimated()
  {
    NSAnimationContext.beginGrouping()
    NSAnimationContext.current.duration = 0.4
    NSAnimationContext.current.completionHandler = {
      self.close()
    }
    window?.animator().alphaValue = 0.0
    NSAnimationContext.endGrouping()
  }
}
