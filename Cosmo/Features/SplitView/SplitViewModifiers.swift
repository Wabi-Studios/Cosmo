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

struct SplitViewControllerLayoutValueKey: _ViewTraitKey
{
  static var defaultValue: () -> SplitViewController? = { nil }
}

struct SplitViewItemCollapsedViewTraitKey: _ViewTraitKey
{
  static var defaultValue: Binding<Bool> = .constant(false)
}

struct SplitViewItemCanCollapseViewTraitKey: _ViewTraitKey
{
  static var defaultValue: Bool = false
}

struct SplitViewHoldingPriorityTraitKey: _ViewTraitKey
{
  static var defaultValue: NSLayoutConstraint.Priority = .defaultLow
}

extension View
{
  func collapsed(_ value: Binding<Bool>) -> some View
  {
    self
      // Use get/set instead of binding directly, so a view update will be triggered if the binding changes.
      ._trait(SplitViewItemCollapsedViewTraitKey.self, .init
      {
        value.wrappedValue
      } set: {
        value.wrappedValue = $0
      })
  }

  func collapsable() -> some View
  {
    _trait(SplitViewItemCanCollapseViewTraitKey.self, true)
  }

  func holdingPriority(_ priority: NSLayoutConstraint.Priority) -> some View
  {
    _trait(SplitViewHoldingPriorityTraitKey.self, priority)
  }
}
