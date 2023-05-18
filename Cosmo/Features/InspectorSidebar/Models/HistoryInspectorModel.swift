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

import Foundation

final class HistoryInspectorModel: ObservableObject
{
  /// A GitClient instance
  private(set) var gitClient: GitClient

  /// The base URL of the workspace
  private(set) var workspaceURL: URL

  /// The base URL of the workspace
  private(set) var fileURL: String

  /// The selected branch from the GitClient
  @Published
  var commitHistory: [GitCommit]

  /// Initialize with a GitClient
  /// - Parameter workspaceURL: the current workspace URL
  ///
  init(workspaceURL: URL, fileURL: String)
  {
    self.workspaceURL = workspaceURL
    self.fileURL = fileURL
    gitClient = GitClient(directoryURL: workspaceURL, shellClient: currentWorld.shellClient)
    do
    {
      let commitHistory = try gitClient.getCommitHistory(entries: 40, fileLocalPath: fileURL)
      self.commitHistory = commitHistory
    }
    catch
    {
      commitHistory = []
    }
  }
}
