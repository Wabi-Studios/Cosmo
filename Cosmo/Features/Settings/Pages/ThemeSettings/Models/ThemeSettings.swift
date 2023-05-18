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
  /// A dictionary containing the keys and associated ``Theme/Attributes`` of overridden properties
  ///
  /// ```json
  /// {
  ///   "editor" : {
  ///     "background" : {
  ///       "color" : "#123456"
  ///     },
  ///     ...
  ///   },
  ///   "terminal" : {
  ///     "blue" : {
  ///       "color" : "#1100FF"
  ///     },
  ///     ...
  ///   }
  /// }
  /// ```
  typealias ThemeOverrides = [String: [String: Theme.Attributes]]

  /// The global settings for themes
  struct ThemeSettings: Codable, Hashable
  {
    /// The name of the currently selected dark theme
    var selectedDarkTheme: String = "cosmo-xcode-dark"

    /// The name of the currently selected light theme
    var selectedLightTheme: String = "cosmo-xcode-light"

    /// The name of the currently selected theme
    var selectedTheme: String?

    /// Use the system background that matches the appearance setting
    var useThemeBackground: Bool = true

    /// Automatically change theme based on system appearance
    var matchAppearance: Bool = true

    /// Dictionary of themes containing overrides
    ///
    /// ```json
    /// {
    ///   "overrides" : {
    ///     "DefaultDark" : {
    ///       "editor" : {
    ///         "background" : {
    ///           "color" : "#123456"
    ///         },
    ///         ...
    ///       },
    ///       "terminal" : {
    ///         "blue" : {
    ///           "color" : "#1100FF"
    ///         },
    ///         ...
    ///       }
    ///       ...
    ///     },
    ///     ...
    ///   },
    ///   ...
    /// }
    /// ```
    var overrides: [String: ThemeOverrides] = [:]

    /// Default initializer
    init() {}

    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      selectedDarkTheme = try container.decodeIfPresent(
        String.self, forKey: .selectedDarkTheme
      ) ?? selectedDarkTheme
      selectedLightTheme = try container.decodeIfPresent(
        String.self, forKey: .selectedLightTheme
      ) ?? selectedLightTheme
      selectedTheme = try container.decodeIfPresent(String.self, forKey: .selectedTheme)
      useThemeBackground = try container.decodeIfPresent(Bool.self, forKey: .useThemeBackground) ?? true
      matchAppearance = try container.decodeIfPresent(
        Bool.self, forKey: .matchAppearance
      ) ?? true
      overrides = try container.decodeIfPresent([String: ThemeOverrides].self, forKey: .overrides) ?? [:]
    }
  }
}
