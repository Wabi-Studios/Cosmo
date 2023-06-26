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

struct SourceControlNavigatorChangesView: View
{
  @ObservedObject
  var model: SourceControlModel

  @State
  var selectedFile: GitChangedFile.ID?

  /// Initialize with GitClient
  /// - Parameter gitClient: a GitClient
  init(workspaceURL: URL)
  {
    model = .init(workspaceURL: workspaceURL)
  }

  var body: some View
  {
    VStack(alignment: .center)
    {
      if model.changed.isEmpty
      {
        Text("No Changes")
          .font(.system(size: 16))
          .foregroundColor(.secondary)
      }
      else
      {
        List(selection: $selectedFile)
        {
          Section("Local Changes")
          {
            ForEach(model.changed)
            { file in
              SourceControlNavigatorChangedFileView(
                changedFile: file,
                selection: $selectedFile,
                workspaceURL: model.workspaceURL
              )
            }
          }
          .foregroundColor(.secondary)
        }
        .listStyle(.sidebar)
      }
    }
    .frame(maxHeight: .infinity)
  }
}
