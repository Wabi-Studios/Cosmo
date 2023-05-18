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

final class FindNavigatorListViewController: NSViewController
{
  public var workspace: WorkspaceDocument
  public var selectedItem: Any?

  private var searchId: UUID?
  private var searchItems: [SearchResultModel] = []
  private var scrollView: NSScrollView!
  private var outlineView: NSOutlineView!
  private let prefs = Settings.shared.preferences
  private var collapsedRows: Set<Int> = []

  var rowHeight: Double = 22
  {
    didSet
    {
      outlineView?.reloadData()
    }
  }

  /// Setup the `scrollView` and `outlineView`
  override func loadView()
  {
    scrollView = NSScrollView()
    view = scrollView

    outlineView = NSOutlineView()
    outlineView.dataSource = self
    outlineView.delegate = self
    outlineView.headerView = nil
    outlineView.lineBreakMode = .byTruncatingTail

    let column = NSTableColumn(identifier: .init(rawValue: "Cell"))
    column.title = "Cell"
    outlineView.addTableColumn(column)

    scrollView.documentView = outlineView
    scrollView.contentView.automaticallyAdjustsContentInsets = false
    scrollView.contentView.contentInsets = .init(top: 0, left: 0, bottom: 0, right: 0)
  }

  init(workspace: WorkspaceDocument)
  {
    self.workspace = workspace
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder)
  {
    fatalError("init?(coder: NSCoder) not implemented by FindNavigatorListViewController")
  }

  override var acceptsFirstResponder: Bool { true }

  /// Sets the search items for the view without loading anything.
  /// - Parameter searchItems: The search items to set.
  public func setSearchResults(_ searchItems: [SearchResultModel])
  {
    self.searchItems = searchItems
  }

  /// Updates the view with new search results and updates the UI.
  /// - Parameter searchItems: The search items to set.
  /// - Parameter searchText: The search text, used to preserve result deletions across view updates.
  public func updateNewSearchResults(_ searchItems: [SearchResultModel], searchId: UUID?)
  {
    if searchId != self.searchId
    {
      self.searchItems = searchItems
      outlineView.reloadData()
      outlineView.expandItem(nil, expandChildren: true)

      self.searchId = searchId
    }

    if let selectedItem
    {
      selectSearchResult(selectedItem)
    }
  }

  override func keyUp(with event: NSEvent)
  {
    if event.charactersIgnoringModifiers == String(NSEvent.SpecialKey.delete.unicodeScalar)
    {
      deleteSelectedItem()
    }
    super.keyUp(with: event)
  }

  /// Removes the selected item, called in response to an action like the backspace
  /// character
  private func deleteSelectedItem()
  {
    let selectedRow = outlineView.selectedRow
    guard selectedRow >= 0,
          let selectedItem = outlineView.item(atRow: selectedRow) else { return }

    if selectedItem is SearchResultMatchModel
    {
      guard let parent = outlineView.parent(forItem: selectedItem) else { return }

      // Remove the item from the search results
      let parentIndex = outlineView.childIndex(forItem: parent)
      let childIndex = outlineView.childIndex(forItem: selectedItem)
      searchItems[parentIndex].lineMatches.remove(at: childIndex)

      // If this was the last child, we need to remove the parent or we'll
      // hit an exception
      if searchItems[parentIndex].lineMatches.isEmpty
      {
        searchItems.remove(at: parentIndex)
        outlineView.removeItems(at: IndexSet([parentIndex]), inParent: nil)
      }
      else
      {
        outlineView.removeItems(at: IndexSet([childIndex]), inParent: parent)
      }
    }
    else
    {
      let index = outlineView.childIndex(forItem: selectedItem)
      searchItems.remove(at: index)
      outlineView.removeItems(at: IndexSet([index]), inParent: nil)
    }

    outlineView.selectRowIndexes(IndexSet([selectedRow]), byExtendingSelection: false)
  }

  public func selectSearchResult(_ selectedItem: Any)
  {
    let index = outlineView.row(forItem: selectedItem)
    guard index >= 0, index != outlineView.selectedRow else { return }
    outlineView.selectRowIndexes(IndexSet([index]), byExtendingSelection: false)
  }
}

// MARK: - NSOutlineViewDataSource

extension FindNavigatorListViewController: NSOutlineViewDataSource
{
  func outlineView(_: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int
  {
    if let item = item as? SearchResultModel
    {
      return item.lineMatches.count
    }
    return searchItems.count
  }

  func outlineView(_: NSOutlineView, child index: Int, ofItem item: Any?) -> Any
  {
    if let item = item as? SearchResultModel
    {
      return item.lineMatches[index]
    }
    return searchItems[index]
  }

  func outlineView(_: NSOutlineView, isItemExpandable item: Any) -> Bool
  {
    if item is SearchResultModel
    {
      return true
    }
    return false
  }
}

// MARK: - NSOutlineViewDelegate

extension FindNavigatorListViewController: NSOutlineViewDelegate
{
  func outlineView(
    _: NSOutlineView,
    shouldShowCellExpansionFor _: NSTableColumn?,
    item: Any
  ) -> Bool
  {
    item as? SearchResultModel != nil
  }

  func outlineView(_: NSOutlineView, shouldShowOutlineCellForItem _: Any) -> Bool
  {
    true
  }

  func outlineView(_: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView?
  {
    guard let tableColumn else { return nil }
    if let item = item as? SearchResultMatchModel
    {
      let frameRect = NSRect(x: 0, y: 0, width: tableColumn.width, height: CGFloat.greatestFiniteMagnitude)
      return FindNavigatorListMatchCell(frame: frameRect, matchItem: item)
    }
    else
    {
      let frameRect = NSRect(
        x: 0,
        y: 0,
        width: tableColumn.width,
        height: prefs.general.projectNavigatorSize.rowHeight
      )
      let view = ProjectNavigatorTableViewCell(
        frame: frameRect,
        item: (item as? SearchResultModel)?.file,
        isEditable: false
      )
      // We're using a medium label for file names b/c it makes it easier to
      // distinguish quickly which results are from which files.
      view.label.font = .systemFont(ofSize: 13, weight: .medium)
      return view
    }
  }

  func outlineViewSelectionDidChange(_ notification: Notification)
  {
    guard let outlineView = notification.object as? NSOutlineView
    else
    {
      return
    }

    let selectedIndex = outlineView.selectedRow

    if let item = outlineView.item(atRow: selectedIndex) as? SearchResultMatchModel
    {
      let selectedMatch = selectedItem as? SearchResultMatchModel
      if selectedItem == nil || selectedMatch != item
      {
        selectedItem = item
        workspace.tabManager.openTab(item: item.file)
      }
    }
    else if let item = outlineView.item(atRow: selectedIndex) as? SearchResultModel
    {
      let selectedFile = selectedItem as? SearchResultModel
      if selectedItem == nil || selectedFile != item
      {
        selectedItem = item
        workspace.tabManager.openTab(item: item.file)
      }
    }
  }

  func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat
  {
    if let item = item as? SearchResultMatchModel
    {
      let tempView = NSTextField(wrappingLabelWithString: item.attributedLabel().string)
      tempView.allowsDefaultTighteningForTruncation = false
      tempView.cell?.truncatesLastVisibleLine = true
      tempView.cell?.wraps = true
      tempView.maximumNumberOfLines = 3
      tempView.attributedStringValue = item.attributedLabel()
      tempView.layout()
      let width = outlineView.frame.width - outlineView.indentationPerLevel * 2 - 24
      return tempView.sizeThatFits(
        NSSize(width: width, height: CGFloat.greatestFiniteMagnitude)
      ).height + 8
    }
    else
    {
      return rowHeight
    }
  }

  func outlineViewColumnDidResize(_: Notification)
  {
    let indexes = IndexSet(integersIn: 0 ..< searchItems.count)
    outlineView.noteHeightOfRows(withIndexesChanged: indexes)
  }
}

// MARK: - NSMenuDelegate

extension FindNavigatorListViewController: NSMenuDelegate
{}
