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
  /// The global settings for text editing
  struct AccountsSettings: Codable, Hashable
  {
    /// An integer indicating how many spaces a `tab` will generate
    var sourceControlAccounts: GitAccounts = .init()

    /// Default initializer
    init() {}

    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      sourceControlAccounts = try container.decodeIfPresent(
        GitAccounts.self,
        forKey: .sourceControlAccounts
      ) ?? .init()
    }
  }

  struct GitAccounts: Codable, Hashable
  {
    /// This id will store the account name as the identifiable
    var gitAccounts: [SourceControlAccount] = []

    var sshKey: String = ""
    /// Default initializer
    init() {}
    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      gitAccounts = try container.decodeIfPresent([SourceControlAccount].self, forKey: .gitAccounts) ?? []
      sshKey = try container.decodeIfPresent(String.self, forKey: .sshKey) ?? ""
    }
  }
}
