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

import SwiftUI

struct HistoryInspectorView: View
{
  @ObservedObject
  private var model: HistoryInspectorModel

  @State var selectedCommitHistory: GitCommit?

  /// Initialize with GitClient
  /// - Parameter gitClient: a GitClient
  init(workspaceURL: URL, fileURL: String)
  {
    model = .init(workspaceURL: workspaceURL, fileURL: fileURL)
  }

  var body: some View
  {
    VStack
    {
      if model.commitHistory.isEmpty
      {
        HistoryInspectorNoHistoryView()
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      }
      else
      {
        List(selection: $selectedCommitHistory)
        {
          ForEach(model.commitHistory)
          { commit in
            HistoryInspectorItemView(commit: commit, selection: $selectedCommitHistory)
              .tag(commit)
          }
        }
        .listStyle(.inset)
      }
    }
  }
}
