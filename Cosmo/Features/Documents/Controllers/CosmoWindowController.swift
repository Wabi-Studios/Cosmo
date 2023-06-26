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

final class CosmoWindowController: NSWindowController, NSToolbarDelegate, ObservableObject
{
  static let minSidebarWidth: CGFloat = 242

  @Published var navigatorCollapsed = false
  @Published var inspectorCollapsed = false

  var observers: [NSKeyValueObservation] = []

  var workspace: WorkspaceDocument?
  var quickOpenPanel: OverlayPanel?
  var commandPalettePanel: OverlayPanel?

  var splitViewController: NSSplitViewController!

  init(window: NSWindow, workspace: WorkspaceDocument)
  {
    super.init(window: window)
    self.workspace = workspace

    setupSplitView(with: workspace)

    let view = CosmoSplitView(controller: splitViewController).ignoresSafeArea()

    // An NSHostingController is used, so the root viewController of the window is a SwiftUI-managed one.
    // This allows us to use some SwiftUI features, like focusedSceneObject.
    contentViewController = NSHostingController(rootView: view)

    observers = [
      splitViewController.splitViewItems.first!.observe(\.isCollapsed, changeHandler: { [weak self] item, _ in
        self?.navigatorCollapsed = item.isCollapsed
      }),
      splitViewController.splitViewItems.last!.observe(\.isCollapsed, changeHandler: { [weak self] item, _ in
        self?.navigatorCollapsed = item.isCollapsed
      }),
    ]

    setupToolbar()
    registerCommands()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }

  /// These are example items that added as commands to command palette
  func registerCommands()
  {
    CommandManager.shared.addCommand(
      name: "Quick Open",
      title: "Quick Open",
      id: "quick_open",
      command: CommandClosureWrapper(closure: {
        self.openQuickly(self)
      })
    )

    CommandManager.shared.addCommand(
      name: "Toggle Left Sidebar",
      title: "Toggle Left Sidebar",
      id: "toggle_left_sidebar",
      command: CommandClosureWrapper(closure: {
        self.toggleFirstPanel()
      })
    )

    CommandManager.shared.addCommand(
      name: "Toggle Right Sidebar",
      title: "Toggle Right Sidebar",
      id: "toggle_right_sidebar",
      command: CommandClosureWrapper(closure: {
        self.toggleLastPanel()
      })
    )
  }

  private func setupSplitView(with workspace: WorkspaceDocument)
  {
    let feedbackPerformer = NSHapticFeedbackManager.defaultPerformer
    let splitVC = CosmoSplitViewController(workspace: workspace, feedbackPerformer: feedbackPerformer)

    let navigatorView = SettingsInjector
    {
      NavigatorSidebarView(workspace: workspace)
        .environmentObject(workspace)
        .environmentObject(workspace.tabManager)
    }

    let navigator = NSSplitViewItem(
      sidebarWithViewController: NSHostingController(rootView: navigatorView)
    )
    navigator.titlebarSeparatorStyle = .none
    navigator.minimumThickness = Self.minSidebarWidth
    navigator.collapseBehavior = .useConstraints
    splitVC.addSplitViewItem(navigator)

    let workspaceView = SettingsInjector
    {
      WindowObserver(window: window!)
      {
        WorkspaceView()
          .environmentObject(workspace)
          .environmentObject(workspace.tabManager)
      }
    }

    let mainContent = NSSplitViewItem(
      viewController: NSHostingController(rootView: workspaceView)
    )
    mainContent.titlebarSeparatorStyle = .line
    splitVC.addSplitViewItem(mainContent)

    let inspectorView = SettingsInjector
    {
      InspectorSidebarView(workspace: workspace)
        .environmentObject(workspace)
        .environmentObject(workspace.tabManager)
    }

    let inspector = NSSplitViewItem(
      viewController: NSHostingController(rootView: inspectorView)
    )
    inspector.titlebarSeparatorStyle = .none
    inspector.minimumThickness = Self.minSidebarWidth
    inspector.isCollapsed = true
    inspector.canCollapse = true
    inspector.collapseBehavior = .useConstraints
    inspector.isSpringLoaded = true

    splitVC.addSplitViewItem(inspector)

    splitViewController = splitVC
  }

  private func setupToolbar()
  {
    let toolbar = NSToolbar(identifier: UUID().uuidString)
    toolbar.delegate = self
    toolbar.displayMode = .labelOnly
    toolbar.showsBaselineSeparator = false
    window?.titleVisibility = .hidden
    window?.toolbarStyle = .unifiedCompact
    if Settings[\.general].tabBarStyle == .native
    {
      // Set titlebar background as transparent by default in order to
      // style the toolbar background in native tab bar style.
      window?.titlebarSeparatorStyle = .none
    }
    else
    {
      // In xcode tab bar style, we use default toolbar background with
      // line separator.
      window?.titlebarSeparatorStyle = .automatic
    }
    window?.toolbar = toolbar
  }

  // MARK: - Toolbar

  func toolbarDefaultItemIdentifiers(_: NSToolbar) -> [NSToolbarItem.Identifier]
  {
    [
      .toggleFirstSidebarItem,
      .sidebarTrackingSeparator,
      .branchPicker,
      .flexibleSpace,
      .flexibleSpace,
      .toggleLastSidebarItem,
    ]
  }

  func toolbarAllowedItemIdentifiers(_: NSToolbar) -> [NSToolbarItem.Identifier]
  {
    [
      .toggleFirstSidebarItem,
      .sidebarTrackingSeparator,
      .flexibleSpace,
      .itemListTrackingSeparator,
      .toggleLastSidebarItem,
      .branchPicker,
    ]
  }

  func toolbar(
    _: NSToolbar,
    itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier,
    willBeInsertedIntoToolbar _: Bool
  ) -> NSToolbarItem?
  {
    switch itemIdentifier
    {
      case .itemListTrackingSeparator:
        guard let splitViewController
        else
        {
          return nil
        }

        return NSTrackingSeparatorToolbarItem(
          identifier: .itemListTrackingSeparator,
          splitView: splitViewController.splitView,
          dividerIndex: 1
        )
      case .toggleFirstSidebarItem:
        let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier.toggleFirstSidebarItem)
        toolbarItem.label = "Navigator Sidebar"
        toolbarItem.paletteLabel = " Navigator Sidebar"
        toolbarItem.toolTip = "Hide or show the Navigator"
        toolbarItem.isBordered = true
        toolbarItem.target = self
        toolbarItem.action = #selector(toggleFirstPanel)
        toolbarItem.image = NSImage(
          systemSymbolName: "sidebar.leading",
          accessibilityDescription: nil
        )?.withSymbolConfiguration(.init(scale: .large))

        return toolbarItem
      case .toggleLastSidebarItem:
        let toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier.toggleLastSidebarItem)
        toolbarItem.label = "Inspector Sidebar"
        toolbarItem.paletteLabel = "Inspector Sidebar"
        toolbarItem.toolTip = "Hide or show the Inspectors"
        toolbarItem.isBordered = true
        toolbarItem.target = self
        toolbarItem.action = #selector(toggleLastPanel)
        toolbarItem.image = NSImage(
          systemSymbolName: "sidebar.trailing",
          accessibilityDescription: nil
        )?.withSymbolConfiguration(.init(scale: .large))

        return toolbarItem
      case .branchPicker:
        let toolbarItem = NSToolbarItem(itemIdentifier: .branchPicker)
        let view = NSHostingView(
          rootView: ToolbarBranchPicker(
            shellClient: currentWorld.shellClient,
            workspaceFileManager: workspace?.workspaceFileManager
          )
        )
        toolbarItem.view = view

        return toolbarItem
      default:
        return NSToolbarItem(itemIdentifier: itemIdentifier)
    }
  }

  override func windowDidLoad()
  {
    super.windowDidLoad()
  }

  private func getSelectedCodeFile() -> CodeFileDocument?
  {
    workspace?.tabManager.activeTabGroup.selected?.fileDocument
  }

  @IBAction func saveDocument(_ sender: Any)
  {
    getSelectedCodeFile()?.save(sender)
    workspace?.tabManager.activeTabGroup.temporaryTab = nil
  }

  @IBAction func openCommandPalette(_: Any)
  {
    if let workspace, let state = workspace.commandsPaletteState
    {
      if let commandPalettePanel
      {
        if commandPalettePanel.isKeyWindow
        {
          commandPalettePanel.close()
          state.reset()
          return
        }
        else
        {
          state.reset()
          window?.addChildWindow(commandPalettePanel, ordered: .above)
          commandPalettePanel.makeKeyAndOrderFront(self)
        }
      }
      else
      {
        let panel = OverlayPanel()
        commandPalettePanel = panel
        let contentView = CommandPaletteView(state: state, closePalette: panel.close)
        panel.contentView = NSHostingView(rootView: SettingsInjector { contentView })
        window?.addChildWindow(panel, ordered: .above)
        panel.makeKeyAndOrderFront(self)
      }
    }
  }

  @IBAction func openQuickly(_: Any)
  {
    if let workspace, let state = workspace.quickOpenViewModel
    {
      if let quickOpenPanel
      {
        if quickOpenPanel.isKeyWindow
        {
          quickOpenPanel.close()
          return
        }
        else
        {
          window?.addChildWindow(quickOpenPanel, ordered: .above)
          quickOpenPanel.makeKeyAndOrderFront(self)
        }
      }
      else
      {
        let panel = OverlayPanel()
        quickOpenPanel = panel

        let contentView = QuickOpenView(state: state)
        {
          panel.close()
        } openFile: { file in
          workspace.tabManager.openTab(item: file)
        }

        panel.contentView = NSHostingView(rootView: SettingsInjector { contentView })
        window?.addChildWindow(panel, ordered: .above)
        panel.makeKeyAndOrderFront(self)
      }
    }
  }
}

extension CosmoWindowController
{
  @objc
  func toggleFirstPanel()
  {
    guard let firstSplitView = splitViewController.splitViewItems.first else { return }
    firstSplitView.animator().isCollapsed.toggle()
    if let cosmoSplitVC = splitViewController as? CosmoSplitViewController
    {
      cosmoSplitVC.saveNavigatorCollapsedState(isCollapsed: firstSplitView.isCollapsed)
    }
  }

  @objc
  func toggleLastPanel()
  {
    guard let lastSplitView = splitViewController.splitViewItems.last else { return }

    if let toolbar = window?.toolbar,
       lastSplitView.isCollapsed,
       !toolbar.items.map(\.itemIdentifier).contains(.itemListTrackingSeparator)
    {
      window?.toolbar?.insertItem(withItemIdentifier: .itemListTrackingSeparator, at: 4)
    }
    NSAnimationContext.runAnimationGroup
    { _ in
      lastSplitView.animator().isCollapsed.toggle()
    } completionHandler: { [weak self] in
      if lastSplitView.isCollapsed
      {
        self?.window?.animator().toolbar?.removeItem(at: 4)
      }
    }

    if let cosmoSplitVC = splitViewController as? CosmoSplitViewController
    {
      cosmoSplitVC.saveInspectorCollapsedState(isCollapsed: lastSplitView.isCollapsed)
      cosmoSplitVC.hideInspectorToolbarBackground()
    }
  }
}

extension NSToolbarItem.Identifier
{
  static let toggleFirstSidebarItem: NSToolbarItem.Identifier = .init("ToggleFirstSidebarItem")
  static let toggleLastSidebarItem: NSToolbarItem.Identifier = .init("ToggleLastSidebarItem")
  static let itemListTrackingSeparator = NSToolbarItem.Identifier("ItemListTrackingSeparator")
  static let branchPicker: NSToolbarItem.Identifier = .init("BranchPicker")
}
