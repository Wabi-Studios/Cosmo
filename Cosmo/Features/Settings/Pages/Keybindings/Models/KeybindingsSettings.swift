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

extension SettingsData
{
  /// The global settings for text editing
  struct KeybindingsSettings: Codable, Hashable
  {
    /// An integer indicating how many spaces a `tab` will generate
    var keybindings: [String: KeyboardShortcutWrapper] = .init()

    /// Default initializer
    init()
    {
      keybindings = KeybindingManager.shared.keyboardShortcuts
    }

    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      keybindings = try container.decodeIfPresent(
        [String: KeyboardShortcutWrapper].self,
        forKey: .keybindings
      ) ?? .init()
      appendNew()

      let mgr = CommandManager.shared
      let wrap = CommandClosureWrapper(closure: {
        print("testing closure")
      })
      mgr.addCommand(
        name: "Send test to console",
        title: "Send test to console", id: "cosmo.test", command: wrap
      )
      mgr.executeCommand(name: "test")
    }

    /// Adds new keybindings if they were added to default_keybindings.json.
    /// To ensure users will get new keybindings with new app version releases
    private mutating func appendNew()
    {
      let newKeybindings = KeybindingManager.shared
        .keyboardShortcuts.filter { !keybindings.keys.contains($0.key) }
      for keybinding in newKeybindings
      {
        keybindings[keybinding.key] = KeybindingManager.shared.named(with: keybinding.key)
      }
    }
  }
}
