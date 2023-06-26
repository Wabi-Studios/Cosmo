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

/// This model handle the fetching and adding of changes etc... for the
/// Source Control Navigator
final class SourceControlModel: ObservableObject
{
  /// A GitClient instance
  let gitClient: GitClient

  /// The base URL of the workspace
  let workspaceURL: URL

  /// A list of changed files
  @Published
  var changed: [GitChangedFile]

  /// Initialize with a GitClient
  /// - Parameter workspaceURL: the current workspace URL we also need this to open files in finder
  ///
  init(workspaceURL: URL)
  {
    self.workspaceURL = workspaceURL
    gitClient = GitClient(directoryURL: workspaceURL, shellClient: currentWorld.shellClient)
    do
    {
      changed = try gitClient.getChangedFiles()
    }
    catch
    {
      changed = []
    }
  }
}
