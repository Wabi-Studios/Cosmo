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

import Combine
import SwiftUI

class SplitViewItem: ObservableObject
{
  var id: AnyHashable
  var item: NSSplitViewItem

  var collapsed: Binding<Bool>

  var cancellables: [AnyCancellable] = []

  var observers: [NSKeyValueObservation] = []

  init(child: _VariadicView.Children.Element)
  {
    id = child.id
    item = NSSplitViewItem(viewController: NSHostingController(rootView: child))
    collapsed = child[SplitViewItemCollapsedViewTraitKey.self]
    item.canCollapse = child[SplitViewItemCanCollapseViewTraitKey.self]
    item.isCollapsed = collapsed.wrappedValue
    item.holdingPriority = child[SplitViewHoldingPriorityTraitKey.self]
    observers = createObservers()
  }

  private func createObservers() -> [NSKeyValueObservation]
  {
    [
      item.observe(\.isCollapsed)
      { [weak self] item, _ in
        self?.collapsed.wrappedValue = item.isCollapsed
      },
    ]
  }

  /// Updates a SplitViewItem.
  /// This will fetch updated binding values and update them if needed.
  /// - Parameter child: the view corresponding to the SplitViewItem.
  func update(child: _VariadicView.Children.Element)
  {
    item.canCollapse = child[SplitViewItemCanCollapseViewTraitKey.self]
    DispatchQueue.main.async
    {
      self.observers = []
      self.item.animator().isCollapsed = child[SplitViewItemCollapsedViewTraitKey.self].wrappedValue
      self.item.holdingPriority = child[SplitViewHoldingPriorityTraitKey.self]
      self.observers = self.createObservers()
    }
  }
}
