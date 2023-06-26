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

import DequeModule
import Foundation
import OrderedCollections

class TabManager: ObservableObject
{
  /// Collection of all the tabgroups.
  @Published
  var tabGroups: TabGroup

  /// The TabGroup with active focus.
  @Published
  var activeTabGroup: TabGroupData
  {
    didSet
    {
      activeTabGroupHistory.prepend { [weak oldValue] in oldValue }
    }
  }

  /// History of last-used tab groups.
  var activeTabGroupHistory: Deque<() -> TabGroupData?> = []

  var fileDocuments: [CEWorkspaceFile: CodeFileDocument] = [:]

  init()
  {
    let tab = TabGroupData()
    activeTabGroup = tab
    activeTabGroupHistory.prepend { [weak tab] in tab }
    tabGroups = .horizontal(.init(.horizontal, tabgroups: [.one(tab)]))
  }

  /// Flattens the splitviews.
  func flatten()
  {
    if case let .horizontal(data) = tabGroups
    {
      data.flatten()
    }
  }

  /// Opens a new tab in a tabgroup.
  /// - Parameters:
  ///   - item: The tab to open.
  ///   - tabgroup: The tabgroup to add the tab to. If nil, it is added to the active tab group.
  func openTab(item: CEWorkspaceFile, in tabgroup: TabGroupData? = nil)
  {
    let tabgroup = tabgroup ?? activeTabGroup
    tabgroup.openTab(item: item)
  }
}
