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
import SwiftUI

struct CosmoSplitView: NSViewControllerRepresentable
{
  let controller: NSSplitViewController

  func makeNSViewController(context _: Context) -> NSSplitViewController
  {
    controller
  }

  func updateNSViewController(_: NSSplitViewController, context _: Context) {}
}

private extension CGFloat
{
  static let snapWidth: CGFloat = 272

  static let minSnapWidth: CGFloat = snapWidth - 10
  static let maxSnapWidth: CGFloat = snapWidth + 10
}

final class CosmoSplitViewController: NSSplitViewController
{
  private var workspace: WorkspaceDocument
  private let widthStateName: String = "\(String(describing: CosmoSplitViewController.self))-Width"
  private let isNavigatorCollapsedStateName: String
    = "\(String(describing: CosmoSplitViewController.self))-IsNavigatorCollapsed"
  private let isInspectorCollapsedStateName: String
    = "\(String(describing: CosmoSplitViewController.self))-IsInspectorCollapsed"
  private var setWidthFromState = false
  private var viewIsReady = false

  /// Properties
  private(set) var isSnapped: Bool = false
  {
    willSet
    {
      if newValue, newValue != isSnapped, viewIsReady
      {
        feedbackPerformer.perform(.alignment, performanceTime: .now)
      }
    }
  }

  /// Dependencies
  private let feedbackPerformer: NSHapticFeedbackPerformer

  // MARK: - Initialization

  init(workspace: WorkspaceDocument, feedbackPerformer: NSHapticFeedbackPerformer)
  {
    self.workspace = workspace
    self.feedbackPerformer = feedbackPerformer
    super.init(nibName: nil, bundle: nil)
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear()
  {
    super.viewWillAppear()

    viewIsReady = false
    let width = workspace.getFromWorkspaceState(key: widthStateName) as? CGFloat
    splitView.setPosition(width ?? .snapWidth, ofDividerAt: .zero)
    setWidthFromState = true

    if let firstSplitView = splitViewItems.first
    {
      firstSplitView.isCollapsed = workspace.getFromWorkspaceState(
        key: isNavigatorCollapsedStateName
      ) as? Bool ?? false
    }

    if let lastSplitView = splitViewItems.last
    {
      lastSplitView.isCollapsed = workspace.getFromWorkspaceState(
        key: isInspectorCollapsedStateName
      ) as? Bool ?? true
    }

    insertToolbarItemIfNeeded()
  }

  override func viewDidAppear()
  {
    viewIsReady = true
    hideInspectorToolbarBackground()
  }

  // MARK: - NSSplitViewDelegate

  override func splitView(
    _: NSSplitView,
    constrainSplitPosition proposedPosition: CGFloat,
    ofSubviewAt dividerIndex: Int
  ) -> CGFloat
  {
    if dividerIndex == 0
    {
      // Navigator
      if (CGFloat.minSnapWidth ... CGFloat.maxSnapWidth).contains(proposedPosition)
      {
        isSnapped = true
        return .snapWidth
      }
      else
      {
        isSnapped = false
        if proposedPosition <= CosmoWindowController.minSidebarWidth / 2
        {
          splitViewItems.first?.isCollapsed = true
          return 0
        }
        return max(CosmoWindowController.minSidebarWidth, proposedPosition)
      }
    }
    else if dividerIndex == 1
    {
      let proposedWidth = view.frame.width - proposedPosition
      if proposedWidth <= CosmoWindowController.minSidebarWidth / 2
      {
        splitViewItems.last?.isCollapsed = true
        removeToolbarItemIfNeeded()
        return proposedPosition
      }
      splitViewItems.last?.isCollapsed = false
      insertToolbarItemIfNeeded()
      return min(view.frame.width - CosmoWindowController.minSidebarWidth, proposedPosition)
    }
    return proposedPosition
  }

  override func splitViewDidResizeSubviews(_ notification: Notification)
  {
    guard let resizedDivider = notification.userInfo?["NSSplitViewDividerIndex"] as? Int
    else
    {
      return
    }

    if resizedDivider == 0
    {
      let panel = splitView.subviews[0]
      let width = panel.frame.size.width
      if width > 0, setWidthFromState
      {
        workspace.addToWorkspaceState(key: widthStateName, value: width)
      }
    }
  }

  func saveNavigatorCollapsedState(isCollapsed: Bool)
  {
    workspace.addToWorkspaceState(key: isNavigatorCollapsedStateName, value: isCollapsed)
  }

  func saveInspectorCollapsedState(isCollapsed: Bool)
  {
    workspace.addToWorkspaceState(key: isInspectorCollapsedStateName, value: isCollapsed)
  }

  /// Quick fix for list tracking separator needing to be added again after closing,
  /// then opening the inspector with a drag.
  private func insertToolbarItemIfNeeded()
  {
    guard !(
      view.window?.toolbar?.items.contains(where: { $0.itemIdentifier == .itemListTrackingSeparator }) ?? true
    )
    else
    {
      return
    }
    view.window?.toolbar?.insertItem(withItemIdentifier: .itemListTrackingSeparator, at: 4)
  }

  /// Quick fix for list tracking separator needing to be removed after closing the inspector with a drag
  private func removeToolbarItemIfNeeded()
  {
    guard let index = view.window?.toolbar?.items.firstIndex(
      where: { $0.itemIdentifier == .itemListTrackingSeparator }
    )
    else
    {
      return
    }
    view.window?.toolbar?.removeItem(at: index)
  }

  func hideInspectorToolbarBackground()
  {
    let controller = view.window?.perform(Selector(("titlebarViewController"))).takeUnretainedValue()
    if let controller = controller as? NSViewController
    {
      let effectViewCount = controller.view.subviews.filter { $0 is NSVisualEffectView }.count
      guard effectViewCount > 2 else { return }
      if let view = controller.view.subviews[0] as? NSVisualEffectView
      {
        view.isHidden = true
      }
    }
  }
}
