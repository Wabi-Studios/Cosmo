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
  /// The global settings for the terminal emulator
  struct TerminalSettings: Codable, Hashable
  {
    /// If true terminal will use editor theme.
    var useEditorTheme: Bool = true

    /// If true terminal appearance will always be `dark`. Otherwise it adapts to the system setting.
    var darkAppearance: Bool = false

    /// If true, the terminal uses the background color of the theme, otherwise it is clear
    var useThemeBackground: Bool = true

    /// If true, the terminal treats the `Option` key as the `Meta` key
    var optionAsMeta: Bool = false

    /// The selected shell to use.
    var shell: TerminalShell = .system

    /// The font to use in terminal.
    var font: TerminalFont = .init()

    /// The cursor style to use in terminal
    var cursorStyle: TerminalCursorStyle = .block

    /// Toggle for blinking cursor or not
    var cursorBlink: Bool = false

    /// Use font settings from Text Editing
    var useTextEditorFont: Bool = true

    /// Default initializer
    init() {}

    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      darkAppearance = try container.decodeIfPresent(Bool.self, forKey: .darkAppearance) ?? false
      optionAsMeta = try container.decodeIfPresent(Bool.self, forKey: .optionAsMeta) ?? false
      shell = try container.decodeIfPresent(TerminalShell.self, forKey: .shell) ?? .system
      font = try container.decodeIfPresent(TerminalFont.self, forKey: .font) ?? .init()
      cursorStyle = try container.decodeIfPresent(
        TerminalCursorStyle.self,
        forKey: .cursorStyle
      ) ?? .block
      cursorBlink = try container.decodeIfPresent(Bool.self, forKey: .cursorBlink) ?? false
      useTextEditorFont = try container.decodeIfPresent(Bool.self, forKey: .useTextEditorFont) ?? true
    }
  }

  /// The shell options.
  /// - **bash**: uses the default bash shell
  /// - **zsh**: uses the ZSH shell
  /// - **system**: uses the system default shell (most likely ZSH)
  enum TerminalShell: String, Codable, Hashable
  {
    case bash
    case zsh
    case system
  }

  enum TerminalCursorStyle: String, Codable, Hashable
  {
    case block
    case underline
    case bar
  }

  struct TerminalFont: Codable, Hashable
  {
    /// Indicates whether or not to use a custom font
    var customFont: Bool = false

    /// The font size for the custom font
    var size: Double = 12

    /// The name of the custom font
    var name: String = "FiraCode NF"

    /// Default initializer
    init() {}

    /// Explicit decoder init for setting default values when key is not present in `JSON`
    init(from decoder: Decoder) throws
    {
      let container = try decoder.container(keyedBy: CodingKeys.self)
      customFont = try container.decodeIfPresent(Bool.self, forKey: .customFont) ?? false
      size = try container.decodeIfPresent(Double.self, forKey: .size) ?? 11
      name = try container.decodeIfPresent(String.self, forKey: .name) ?? "FiraCode NF"
    }
  }
}
