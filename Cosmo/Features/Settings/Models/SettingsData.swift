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

/// # Settings
///
/// The model structure of settings for `Cosmo`
///
/// A `JSON` representation is persisted in `~/Library/Application Support/Cosmo/preference.json`.
/// - Attention: Don't use `UserDefaults` for persisting user accessible settings.
///  If a further setting is needed, extend the struct like ``GeneralSettings``,
///  ``ThemeSettings``,  or ``TerminalSettings`` does.
///
/// - Note: Also make sure to implement the ``init(from:)`` initializer, decoding
///  all properties with
///  [`decodeIfPresent`](https://developer.apple.com/documentation/swift/keyeddecodingcontainer/2921389-decodeifpresent)
///  and providing a default value. Otherwise all settings get overridden.
struct SettingsData: Codable, Hashable
{
  /// The general global setting
  var general: GeneralSettings = .init()

  /// The global settings for text editing
  var accounts: AccountsSettings = .init()

  /// The global settings for themes
  var theme: ThemeSettings = .init()

  /// The global settings for the terminal emulator
  var terminal: TerminalSettings = .init()

  /// The global settings for text editing
  var textEditing: TextEditingSettings = .init()

  /// The global settings for text editing
  var sourceControl: SourceControlSettings = .init()

  /// The global settings for keybindings
  var keybindings: KeybindingsSettings = .init()

  /// Default initializer
  init() {}

  /// Explicit decoder init for setting default values when key is not present in `JSON`
  init(from decoder: Decoder) throws
  {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    general = try container.decodeIfPresent(GeneralSettings.self, forKey: .general) ?? .init()
    accounts = try container.decodeIfPresent(AccountsSettings.self, forKey: .accounts) ?? .init()
    theme = try container.decodeIfPresent(ThemeSettings.self, forKey: .theme) ?? .init()
    terminal = try container.decodeIfPresent(TerminalSettings.self, forKey: .terminal) ?? .init()
    textEditing = try container.decodeIfPresent(TextEditingSettings.self, forKey: .textEditing) ?? .init()
    sourceControl = try container.decodeIfPresent(
      SourceControlSettings.self,
      forKey: .sourceControl
    ) ?? .init()
    keybindings = try container.decodeIfPresent(KeybindingsSettings.self, forKey: .keybindings) ?? .init()
  }
}
