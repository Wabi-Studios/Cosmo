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

extension EventModifiers
{
  static var hidden: EventModifiers = .numericPad
}

extension NSMenuItem
{
  /// Helper variable to allow opening SwiftUI windows from anywhere in the app.
  /// Don't use this, unless you know what you're doing.
  static var openWindowAction: (() -> (SceneID?, (any Codable & Hashable)?))?

  @objc
  private func fixAlternate(_ newValue: NSEvent.ModifierFlags)
  {
    if newValue.contains(.numericPad)
    {
      isAlternate = true
      fixAlternate(newValue.subtracting(.numericPad))
    }

    fixAlternate(newValue)

    if title == "Open Recent"
    {
      let openRecentMenu = NSMenu(title: "Open Recent")
      openRecentMenu.perform(NSSelectorFromString("_setMenuName:"), with: "NSRecentDocumentsMenu")
      submenu = openRecentMenu
      NSDocumentController.shared.value(forKey: "_installOpenRecentMenus")
    }

    if title == "OpenWindowAction" || title.isEmpty
    {
      isHidden = true
      allowsKeyEquivalentWhenHidden = true
    }
  }

  static func swizzle()
  {
    let origSelector = #selector(setter: NSMenuItem.keyEquivalentModifierMask)
    let swizzledSelector = #selector(fixAlternate)
    let originalMethodSet = class_getInstanceMethod(self as AnyClass, origSelector)
    let swizzledMethodSet = class_getInstanceMethod(self as AnyClass, swizzledSelector)

    method_exchangeImplementations(originalMethodSet!, swizzledMethodSet!)
  }
}
