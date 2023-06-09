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

import Cocoa

final class OverlayPanel: NSPanel, NSWindowDelegate
{
  init()
  {
    super.init(
      contentRect: NSRect(x: 0, y: 0, width: 500, height: 48),
      styleMask: [.fullSizeContentView, .titled, .resizable],
      backing: .buffered, defer: false
    )
    delegate = self
    center()
    titlebarAppearsTransparent = true
    isMovableByWindowBackground = true
  }

  override func standardWindowButton(_ button: NSWindow.ButtonType) -> NSButton?
  {
    let btn = super.standardWindowButton(button)
    btn?.isHidden = true
    return btn
  }

  func windowDidResignKey(_ notification: Notification)
  {
    if let panel = notification.object as? OverlayPanel
    {
      panel.close()
    }
  }
}
