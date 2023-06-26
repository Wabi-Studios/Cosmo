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

import AppKit
import Foundation

extension NSSplitViewItem
{
  @objc
  private var canCollapseSwizzled: Bool
  {
    if let check = viewController.view.window?.isSettingsWindow, check
    {
      return false
    }
    return self.canCollapseSwizzled
  }

  static func swizzle()
  {
    let origSelector = #selector(getter: NSSplitViewItem.canCollapse)
    let swizzledSelector = #selector(getter: canCollapseSwizzled)
    let originalMethodSet = class_getInstanceMethod(self as AnyClass, origSelector)
    let swizzledMethodSet = class_getInstanceMethod(self as AnyClass, swizzledSelector)

    method_exchangeImplementations(originalMethodSet!, swizzledMethodSet!)
  }
}
