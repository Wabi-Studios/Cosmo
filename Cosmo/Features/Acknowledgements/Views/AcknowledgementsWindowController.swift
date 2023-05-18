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

final class AcknowledgementsViewWindowController: NSWindowController
{
  convenience init(view: some View, size: NSSize)
  {
    let hostingController = NSHostingController(rootView: view)
    // New window holding our SwiftUI view
    let window = NSWindow(contentViewController: hostingController)
    self.init(window: window)
    window.setContentSize(size)
    window.styleMask = [.closable, .fullSizeContentView, .titled, .nonactivatingPanel]
    window.standardWindowButton(.miniaturizeButton)?.isHidden = true
    window.standardWindowButton(.zoomButton)?.isHidden = true
    window.titlebarAppearsTransparent = true
    window.titleVisibility = .hidden
    window.backgroundColor = .gray.withAlphaComponent(0.15)
  }

  override func showWindow(_ sender: Any?)
  {
    window?.center()
    window?.alphaValue = 0.0

    super.showWindow(sender)

    window?.animator().alphaValue = 1.0

    // close the window when the escape key is pressed
    NSEvent.addLocalMonitorForEvents(matching: .keyDown)
    { event in
      guard event.keyCode == 53 else { return event }

      self.closeAnimated()

      return nil
    }

    window?.collectionBehavior = [.transient, .ignoresCycle]
    window?.isMovableByWindowBackground = true
    window?.title = "Acknowledgements"
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
