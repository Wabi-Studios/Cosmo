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
import Foundation

final class QuickOpenViewModel: ObservableObject
{
  @Published
  var openQuicklyQuery: String = ""

  @Published
  var openQuicklyFiles: [CEWorkspaceFile] = []

  @Published
  var isShowingOpenQuicklyFiles: Bool = false

  let fileURL: URL

  private let queue = DispatchQueue(label: "foundation.wabi.cosmo.quickOpen.searchFiles")

  init(fileURL: URL)
  {
    self.fileURL = fileURL
  }

  func fetchOpenQuickly()
  {
    guard openQuicklyQuery != ""
    else
    {
      openQuicklyFiles = []
      isShowingOpenQuicklyFiles = !openQuicklyFiles.isEmpty
      return
    }

    queue.async
    { [weak self] in
      guard let self else { return }
      let enumerator = FileManager.default.enumerator(
        at: fileURL,
        includingPropertiesForKeys: [
          .isRegularFileKey,
        ],
        options: [
          .skipsHiddenFiles,
          .skipsPackageDescendants,
        ]
      )
      if let filePaths = enumerator?.allObjects as? [URL]
      {
        let files = filePaths.filter
        { url in
          let state1 = url.lastPathComponent.lowercased().contains(self.openQuicklyQuery.lowercased())
          do
          {
            let values = try url.resourceValues(forKeys: [.isRegularFileKey])
            return state1 && (values.isRegularFile ?? false)
          }
          catch
          {
            return false
          }
        }.map
        { url in
          CEWorkspaceFile(url: url, children: nil)
        }
        DispatchQueue.main.async
        {
          self.openQuicklyFiles = files
          self.isShowingOpenQuicklyFiles = !self.openQuicklyFiles.isEmpty
        }
      }
    }
  }
}
