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

import Foundation

enum TabGroup
{
  case one(TabGroupData)
  case vertical(SplitViewData)
  case horizontal(SplitViewData)

  /// Closes all tabs which present the given file
  /// - Parameter file: a file.
  func closeAllTabs(of file: CEWorkspaceFile)
  {
    switch self
    {
      case let .one(tabGroupData):
        tabGroupData.tabs.remove(file)
      case let .vertical(data), let .horizontal(data):
        data.tabgroups.forEach
        {
          $0.closeAllTabs(of: file)
        }
    }
  }

  /// Returns some tabgroup, except the given tabgroup.
  /// - Parameter except: the search will exclude this tabgroup.
  /// - Returns: Some tabgroup.
  func findSomeTabGroup(except: TabGroupData? = nil) -> TabGroupData?
  {
    switch self
    {
      case let .one(tabGroupData) where tabGroupData != except:
        return tabGroupData
      case let .vertical(data), let .horizontal(data):
        for tabgroup in data.tabgroups
        {
          if let result = tabgroup.findSomeTabGroup(except: except), result != except
          {
            return result
          }
        }
        return nil
      default:
        return nil
    }
  }

  /// Forms a set of all files currently represented by tabs.
  func gatherOpenFiles() -> Set<CEWorkspaceFile>
  {
    switch self
    {
      case let .one(tabGroupData):
        return Set(tabGroupData.tabs)
      case let .vertical(data), let .horizontal(data):
        return data.tabgroups.map { $0.gatherOpenFiles() }.reduce(into: []) { $0.formUnion($1) }
    }
  }

  /// Flattens the splitviews.
  mutating func flatten(parent: SplitViewData)
  {
    switch self
    {
      case .one:
        break
      case let .horizontal(data), let .vertical(data):
        if data.tabgroups.count == 1
        {
          let one = data.tabgroups[0]
          if case let .one(tabGroupData) = one
          {
            tabGroupData.parent = parent
          }
          self = one
        }
        else
        {
          data.flatten()
        }
    }
  }
}
