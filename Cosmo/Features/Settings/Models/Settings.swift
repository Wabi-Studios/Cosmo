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
import SwiftUI

/// The Preferences View Model. Accessible via the singleton "``SettingsModel/shared``".
///
/// **Usage:**
/// ```swift
/// @StateObject
/// private var prefs: SettingsModel = .shared
/// ```
final class Settings: ObservableObject
{
  /// The publicly available singleton instance of ``SettingsModel``
  static let shared: Settings = .init()

  private var storeTask: AnyCancellable!

  private init()
  {
    preferences = .init()
    preferences = loadSettings()

    storeTask = $preferences.throttle(for: 2, scheduler: RunLoop.main, latest: true).sink
    {
      try? self.savePreferences($0)
    }
  }

  static subscript<T>(_ path: WritableKeyPath<SettingsData, T>, suite: Settings = .shared) -> T
  {
    get
    {
      suite.preferences[keyPath: path]
    }
    set
    {
      suite.preferences[keyPath: path] = newValue
    }
  }

  /// Published instance of the ``Settings`` model.
  ///
  /// Changes are saved automatically.
  @Published
  var preferences: SettingsData

  /// Load and construct ``Settings`` model from
  /// `~/Library/Application Support/Cosmo/settings.json`
  private func loadSettings() -> SettingsData
  {
    if !filemanager.fileExists(atPath: settingsURL.path)
    {
      try? filemanager.createDirectory(at: baseURL, withIntermediateDirectories: false)
      return .init()
    }

    guard let json = try? Data(contentsOf: settingsURL),
          let prefs = try? JSONDecoder().decode(SettingsData.self, from: json)
    else
    {
      return .init()
    }
    return prefs
  }

  /// Save``Settings`` model to
  /// `~/Library/Application Support/Cosmo/settings.json`
  private func savePreferences(_ data: SettingsData) throws
  {
    print("Saving...")
    let data = try JSONEncoder().encode(data)
    let json = try JSONSerialization.jsonObject(with: data)
    let prettyJSON = try JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
    try prettyJSON.write(to: settingsURL, options: .atomic)
  }

  /// Default instance of the `FileManager`
  private let filemanager = FileManager.default

  /// The base URL of settings.
  ///
  /// Points to `~/Library/Application Support/Cosmo/`
  internal var baseURL: URL
  {
    filemanager
      .homeDirectoryForCurrentUser
      .appendingPathComponent("Library/Application Support/Cosmo", isDirectory: true)
  }

  /// The URL of the `settings.json` settings file.
  ///
  /// Points to `~/Library/Application Support/Cosmo/settings.json`
  private var settingsURL: URL
  {
    baseURL
      .appendingPathComponent("settings")
      .appendingPathExtension("json")
  }
}
