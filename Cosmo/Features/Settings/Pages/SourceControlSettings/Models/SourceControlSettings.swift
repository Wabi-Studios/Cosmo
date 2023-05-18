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

extension SettingsData
{
  /// The global settings for source control
  struct SourceControlSettings: Codable, Hashable
  {
    /// The general source control settings
    var general: SourceControlGeneral = .init()
    /// The source control git settings
    var git: SourceControlGit = .init()
    /// Default initializer
    init() {}
    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      general = try container.decodeIfPresent(SourceControlGeneral.self, forKey: .general) ?? .init()
      git = try container.decodeIfPresent(SourceControlGit.self, forKey: .git) ?? .init()
    }
  }

  struct SourceControlGeneral: Codable, Hashable
  {
    /// Indicates whether or not the source control is active
    var enableSourceControl: Bool = true
    /// Indicates whether or not we should include the upstream changes
    var refreshStatusLocally: Bool = false
    /// Indicates whether or not we should include the upstream changes
    var fetchRefreshServerStatus: Bool = false
    /// Indicates whether or not we should include the upstream changes
    var addRemoveAutomatically: Bool = false
    /// Indicates whether or not we should include the upstream changes
    var selectFilesToCommit: Bool = false
    /// Indicates whether or not to show the source control changes
    var showSourceControlChanges: Bool = true
    /// Indicates whether or not we should include the upstream
    var includeUpstreamChanges: Bool = false
    /// Indicates whether or not we should open the reported feedback in the browser
    var openFeedbackInBrowser: Bool = true
    /// The selected value of the comparison view
    var revisionComparisonLayout: RevisionComparisonLayout = .localLeft
    /// The selected value of the control navigator
    var controlNavigatorOrder: ControlNavigatorOrder = .sortByName
    /// The name of the default branch
    var defaultBranchName: String = "main"
    /// Default initializer
    init() {}
    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      enableSourceControl = try container.decodeIfPresent(Bool.self, forKey: .enableSourceControl) ?? true
      refreshStatusLocally = try container.decodeIfPresent(Bool.self, forKey: .refreshStatusLocally) ?? true
      fetchRefreshServerStatus = try container.decodeIfPresent(
        Bool.self,
        forKey: .fetchRefreshServerStatus
      ) ?? true
      addRemoveAutomatically = try container.decodeIfPresent(
        Bool.self,
        forKey: .addRemoveAutomatically
      ) ?? true
      selectFilesToCommit = try container.decodeIfPresent(Bool.self, forKey: .selectFilesToCommit) ?? true
      showSourceControlChanges = try container.decodeIfPresent(
        Bool.self,
        forKey: .showSourceControlChanges
      ) ?? true
      includeUpstreamChanges = try container.decodeIfPresent(
        Bool.self,
        forKey: .includeUpstreamChanges
      ) ?? true
      openFeedbackInBrowser = try container.decodeIfPresent(
        Bool.self,
        forKey: .openFeedbackInBrowser
      ) ?? true
      revisionComparisonLayout = try container.decodeIfPresent(
        RevisionComparisonLayout.self,
        forKey: .revisionComparisonLayout
      ) ?? .localLeft
      controlNavigatorOrder = try container.decodeIfPresent(
        ControlNavigatorOrder.self,
        forKey: .controlNavigatorOrder
      ) ?? .sortByName
      defaultBranchName = try container.decodeIfPresent(String.self, forKey: .defaultBranchName) ?? "main"
    }
  }

  /// The style for comparison View
  /// - **localLeft**: Local Revision on Left Side
  /// - **localRight**: Local Revision on Right Side
  enum RevisionComparisonLayout: String, Codable
  {
    case localLeft
    case localRight
  }

  /// The style for control Navigator
  /// - **sortName**: They are sorted by Name
  /// - **sortDate**: They are sorted by Date
  enum ControlNavigatorOrder: String, Codable
  {
    case sortByName
    case sortByDate
  }

  struct SourceControlGit: Codable, Hashable
  {
    /// The author name
    var authorName: String = ""
    /// The author email
    var authorEmail: String = ""
    /// Indicates what files should be ignored when committing
    var ignoredFiles: [IgnoredFiles] = []
    /// Indicates whether we should rebase when pulling commits
    var preferRebaseWhenPulling: Bool = false
    /// Indicates whether we should show commits per file log
    var showMergeCommitsPerFileLog: Bool = false
    /// Default initializer
    init() {}
    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      authorName = try container.decodeIfPresent(String.self, forKey: .authorName) ?? ""
      authorEmail = try container.decodeIfPresent(String.self, forKey: .authorEmail) ?? ""
      ignoredFiles = try container.decodeIfPresent(
        [IgnoredFiles].self,
        forKey: .ignoredFiles
      ) ?? []
      preferRebaseWhenPulling = try container.decodeIfPresent(
        Bool.self,
        forKey: .preferRebaseWhenPulling
      ) ?? false
      showMergeCommitsPerFileLog = try container.decodeIfPresent(
        Bool.self,
        forKey: .showMergeCommitsPerFileLog
      ) ?? false
    }
  }
}
