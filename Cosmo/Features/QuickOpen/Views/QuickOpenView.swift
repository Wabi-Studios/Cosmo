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

struct QuickOpenView: View
{
  private let onClose: () -> Void
  private let openFile: (CEWorkspaceFile) -> Void

  @ObservedObject
  private var state: QuickOpenViewModel

  @State
  private var selectedItem: CEWorkspaceFile?

  init(
    state: QuickOpenViewModel,
    onClose: @escaping () -> Void,
    openFile: @escaping (CEWorkspaceFile) -> Void
  )
  {
    self.state = state
    self.onClose = onClose
    self.openFile = openFile
  }

  var body: some View
  {
    OverlayView(
      title: "Open Quickly",
      image: Image(systemName: "magnifyingglass"),
      options: $state.openQuicklyFiles,
      text: $state.openQuicklyQuery,
      optionRowHeight: 40
    )
    { file in
      QuickOpenItem(baseDirectory: state.fileURL, fileItem: file)
    } preview: { file in
      QuickOpenPreviewView(item: file)
    } onRowClick: { file in
      openFile(file)
      state.openQuicklyQuery = ""
      onClose()
    } onClose: {
      onClose()
    }
    .onReceive(state.$openQuicklyQuery.debounce(for: 0.2, scheduler: DispatchQueue.main))
    { _ in
      state.fetchOpenQuickly()
    }
  }
}
