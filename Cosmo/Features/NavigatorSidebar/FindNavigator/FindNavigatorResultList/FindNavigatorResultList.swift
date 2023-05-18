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

struct FindNavigatorResultList: NSViewControllerRepresentable
{
  @EnvironmentObject
  var workspace: WorkspaceDocument

  @AppSettings(\.general.projectNavigatorSize) var projectNavigatorSize

  typealias NSViewControllerType = FindNavigatorListViewController

  func makeNSViewController(context: Context) -> FindNavigatorListViewController
  {
    let controller = FindNavigatorListViewController(workspace: workspace)
    controller.setSearchResults(workspace.searchState?.searchResult ?? [])
    controller.rowHeight = projectNavigatorSize.rowHeight
    context.coordinator.controller = controller
    return controller
  }

  func updateNSViewController(_ nsViewController: FindNavigatorListViewController, context _: Context)
  {
    nsViewController.updateNewSearchResults(
      workspace.searchState?.searchResult ?? [],
      searchId: workspace.searchState?.searchId
    )
    if nsViewController.rowHeight != projectNavigatorSize.rowHeight
    {
      nsViewController.rowHeight = projectNavigatorSize.rowHeight
    }
  }

  func makeCoordinator() -> Coordinator
  {
    Coordinator(
      state: workspace.searchState,
      controller: nil
    )
  }

  class Coordinator: NSObject
  {
    init(state: WorkspaceDocument.SearchState?, controller: FindNavigatorListViewController?)
    {
      self.controller = controller
      super.init()
      listener = state?
        .searchResult
        .publisher
        .receive(on: RunLoop.main)
        .collect()
        .sink(receiveValue: { [weak self] searchResults in
          self?.controller?.updateNewSearchResults(searchResults, searchId: state?.searchId)
        })
    }

    var listener: AnyCancellable?
    var controller: FindNavigatorListViewController?

    deinit
    {
      controller = nil
      listener?.cancel()
      listener = nil
    }
  }
}
