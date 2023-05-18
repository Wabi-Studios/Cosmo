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
import Sparkle

class SoftwareUpdater: NSObject, ObservableObject, SPUUpdaterDelegate
{
  private var updater: SPUUpdater?
  private var automaticallyChecksForUpdatesObservation: NSKeyValueObservation?
  private var lastUpdateCheckDateObservation: NSKeyValueObservation?

  @Published
  var automaticallyChecksForUpdates = false
  {
    didSet
    {
      updater?.automaticallyChecksForUpdates = automaticallyChecksForUpdates
    }
  }

  @Published
  var lastUpdateCheckDate: Date?

  @Published
  var includePrereleaseVersions = false
  {
    didSet
    {
      UserDefaults.standard.setValue(includePrereleaseVersions, forKey: "includePrereleaseVersions")
    }
  }

  private var feedURLTask: Task<Void, Never>?

  private func setFeedURL() async
  {
    let url = URL(string: "https://api.github.com/repos/Wabi-Studios/Cosmo/releases/latest")!
    let request = URLRequest(url: url)
    guard let data = try? await URLSession.shared.data(for: request),
          let result = try? JSONDecoder().decode(GHAPIResult.self, from: data.0)
    else
    {
      DispatchQueue.main.async
      {
        self.updater?.setFeedURL(nil)
      }
      return
    }
    URL.appcast = URL(
      string: "https://github.com/Wabi-Studios/Cosmo/releases/download/\(result.tagName)/appcast.xml"
    )!
    DispatchQueue.main.async
    {
      self.updater?.setFeedURL(.appcast)
    }
  }

  override init()
  {
    super.init()
    updater = SPUStandardUpdaterController(
      startingUpdater: true,
      updaterDelegate: self,
      userDriverDelegate: nil
    ).updater

    feedURLTask = Task
    {
      await setFeedURL()
    }

    automaticallyChecksForUpdatesObservation = updater?.observe(
      \.automaticallyChecksForUpdates,
      options: [.initial, .new, .old],
      changeHandler: { [unowned self] updater, change in
        guard change.newValue != change.oldValue else { return }
        automaticallyChecksForUpdates = updater.automaticallyChecksForUpdates
      }
    )

    lastUpdateCheckDateObservation = updater?.observe(
      \.lastUpdateCheckDate,
      options: [.initial, .new, .old],
      changeHandler: { [unowned self] updater, _ in
        lastUpdateCheckDate = updater.lastUpdateCheckDate
      }
    )

    includePrereleaseVersions = UserDefaults.standard.bool(forKey: "includePrereleaseVersions")
  }

  deinit
  {
    feedURLTask?.cancel()
  }

  func allowedChannels(for _: SPUUpdater) -> Set<String>
  {
    if includePrereleaseVersions
    {
      return ["dev"]
    }
    return []
  }

  func checkForUpdates()
  {
    updater?.checkForUpdates()
  }

  private struct GHAPIResult: Codable
  {
    enum CodingKeys: String, CodingKey
    {
      case tagName = "tag_name"
    }

    var tagName: String
  }
}

extension URL
{
  static var appcast = URL(
    string: "https://github.com/Wabi-Studios/Cosmo/releases/download/latest/appcast.xml"
  )!
}

// https://github.com/Wabi-Studios/Cosmo/releases/download/1.0.0-alpha.0/appcast.xml
