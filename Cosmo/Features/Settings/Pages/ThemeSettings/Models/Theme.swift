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

import CodeEditTextView
import SwiftUI

// swiftlint:disable file_length

/// # Theme
///
/// The model structure of themes for the editor & terminal emulator
struct Theme: Identifiable, Codable, Equatable, Hashable, Loopable
{
  enum CodingKeys: String, CodingKey
  {
    case author, license, distributionURL, name, displayName, editor, terminal, version
    case appearance = "type"
    case metadataDescription = "description"
  }

  static func == (lhs: Theme, rhs: Theme) -> Bool
  {
    lhs.id == rhs.id
  }

  /// The `id` of the theme
  var id: String { name }

  /// The `author` of the theme
  var author: String

  /// The `license` of the theme
  var license: String

  /// A short `description` of the theme
  var metadataDescription: String

  /// An URL for reference
  var distributionURL: String

  /// The `unique name` of the theme
  var name: String

  /// The `display name` of the theme
  var displayName: String

  /// The `version` of the theme
  var version: String

  /// The ``ThemeType`` of the theme
  ///
  /// Appears as `"type"` in the `settings.json`
  var appearance: ThemeType

  /// Editor colors of the theme
  var editor: EditorColors

  /// Terminal colors of the theme
  var terminal: TerminalColors

  init(
    editor: EditorColors,
    terminal: TerminalColors,
    author: String,
    license: String,
    metadataDescription: String,
    distributionURL: String,
    name: String,
    displayName: String,
    appearance: ThemeType,
    version: String
  )
  {
    self.author = author
    self.license = license
    self.metadataDescription = metadataDescription
    self.distributionURL = distributionURL
    self.name = name
    self.displayName = displayName
    self.appearance = appearance
    self.version = version
    self.editor = editor
    self.terminal = terminal
  }
}

extension Theme
{
  /// The type of the theme
  /// - **dark**: this is a theme for dark system appearance
  /// - **light**: this is a theme for light system appearance
  enum ThemeType: String, Codable, Hashable
  {
    case dark
    case light
  }
}

// MARK: - Attributes

extension Theme
{
  /// Attributes of a certain field
  ///
  /// As of now it only includes the colors `hex` string and
  /// an accessor for a `SwiftUI` `Color`.
  struct Attributes: Codable, Equatable, Hashable, Loopable
  {
    /// The 24-bit hex string of the color (e.g. #123456)
    var color: String

    init(color: String)
    {
      self.color = color
    }

    /// The `SwiftUI` of ``color``
    var swiftColor: Color
    {
      get
      {
        Color(hex: color)
      }
      set
      {
        color = newValue.hexString
      }
    }

    /// The `NSColor` of ``color``
    var nsColor: NSColor
    {
      get
      {
        NSColor(hex: color)
      }
      set
      {
        color = newValue.hexString
      }
    }
  }
}

extension Theme
{
  /// The editor colors of the theme
  struct EditorColors: Codable, Hashable, Loopable
  {
    var editorTheme: EditorTheme
    {
      get
      {
        .init(
          text: text.nsColor,
          insertionPoint: insertionPoint.nsColor,
          invisibles: invisibles.nsColor,
          background: background.nsColor,
          lineHighlight: lineHighlight.nsColor,
          selection: selection.nsColor,
          keywords: keywords.nsColor,
          commands: commands.nsColor,
          types: types.nsColor,
          attributes: attributes.nsColor,
          variables: variables.nsColor,
          values: values.nsColor,
          numbers: numbers.nsColor,
          strings: strings.nsColor,
          characters: characters.nsColor,
          comments: comments.nsColor
        )
      }
      set
      {
        text.nsColor = newValue.text
        insertionPoint.nsColor = newValue.insertionPoint
        invisibles.nsColor = newValue.invisibles
        background.nsColor = newValue.background
        lineHighlight.nsColor = newValue.lineHighlight
        selection.nsColor = newValue.selection
        keywords.nsColor = newValue.keywords
        commands.nsColor = newValue.commands
        types.nsColor = newValue.types
        attributes.nsColor = newValue.attributes
        variables.nsColor = newValue.variables
        values.nsColor = newValue.values
        numbers.nsColor = newValue.numbers
        strings.nsColor = newValue.strings
        characters.nsColor = newValue.characters
        comments.nsColor = newValue.comments
      }
    }

    var text: Attributes
    var insertionPoint: Attributes
    var invisibles: Attributes
    var background: Attributes
    var lineHighlight: Attributes
    var selection: Attributes
    var keywords: Attributes
    var commands: Attributes
    var types: Attributes
    var attributes: Attributes
    var variables: Attributes
    var values: Attributes
    var numbers: Attributes
    var strings: Attributes
    var characters: Attributes
    var comments: Attributes

    /// Allows to look up properties by their name
    ///
    /// **Example:**
    /// ```swift
    /// editor["text"]
    /// // equal to calling
    /// editor.text
    /// ```
    subscript(key: String) -> Attributes
    {
      get
      {
        switch key
        {
          case "text": return text
          case "insertionPoint": return insertionPoint
          case "invisibles": return invisibles
          case "background": return background
          case "lineHighlight": return lineHighlight
          case "selection": return selection
          case "keywords": return keywords
          case "commands": return commands
          case "types": return types
          case "attributes": return attributes
          case "variables": return variables
          case "values": return values
          case "numbers": return numbers
          case "strings": return strings
          case "characters": return characters
          case "comments": return comments
          default: fatalError("Invalid key")
        }
      }
      set
      {
        switch key
        {
          case "text": text = newValue
          case "insertionPoint": insertionPoint = newValue
          case "invisibles": invisibles = newValue
          case "background": background = newValue
          case "lineHighlight": lineHighlight = newValue
          case "selection": selection = newValue
          case "keywords": keywords = newValue
          case "commands": commands = newValue
          case "types": types = newValue
          case "attributes": attributes = newValue
          case "variables": variables = newValue
          case "values": values = newValue
          case "numbers": numbers = newValue
          case "strings": strings = newValue
          case "characters": characters = newValue
          case "comments": comments = newValue
          default: fatalError("Invalid key")
        }
      }
    }

    init(
      text: Attributes,
      insertionPoint: Attributes,
      invisibles: Attributes,
      background: Attributes,
      lineHighlight: Attributes,
      selection: Attributes,
      keywords: Attributes,
      commands: Attributes,
      types: Attributes,
      attributes: Attributes,
      variables: Attributes,
      values: Attributes,
      numbers: Attributes,
      strings: Attributes,
      characters: Attributes,
      comments: Attributes
    )
    {
      self.text = text
      self.insertionPoint = insertionPoint
      self.invisibles = invisibles
      self.background = background
      self.lineHighlight = lineHighlight
      self.selection = selection
      self.keywords = keywords
      self.commands = commands
      self.types = types
      self.attributes = attributes
      self.variables = variables
      self.values = values
      self.numbers = numbers
      self.strings = strings
      self.characters = characters
      self.comments = comments
    }
  }
}

extension Theme
{
  /// The terminal emulator colors of the theme
  struct TerminalColors: Codable, Hashable, Loopable
  {
    var text: Attributes
    var boldText: Attributes
    var cursor: Attributes
    var background: Attributes
    var selection: Attributes
    var black: Attributes
    var red: Attributes
    var green: Attributes
    var yellow: Attributes
    var blue: Attributes
    var magenta: Attributes
    var cyan: Attributes
    var white: Attributes
    var brightBlack: Attributes
    var brightRed: Attributes
    var brightGreen: Attributes
    var brightYellow: Attributes
    var brightBlue: Attributes
    var brightMagenta: Attributes
    var brightCyan: Attributes
    var brightWhite: Attributes

    var ansiColors: [String]
    {
      [
        black.color,
        red.color,
        green.color,
        yellow.color,
        blue.color,
        magenta.color,
        cyan.color,
        white.color,
        brightBlack.color,
        brightRed.color,
        brightGreen.color,
        brightYellow.color,
        brightBlue.color,
        brightMagenta.color,
        brightCyan.color,
        brightWhite.color,
      ]
    }

    /// Allows to look up properties by their name
    ///
    /// **Example:**
    /// ```swift
    /// terminal["text"]
    /// // equal to calling
    /// terminal.text
    /// ```
    subscript(key: String) -> Attributes
    {
      get
      {
        switch key
        {
          case "text": return text
          case "boldText": return boldText
          case "cursor": return cursor
          case "background": return background
          case "selection": return selection
          case "black": return black
          case "red": return red
          case "green": return green
          case "yellow": return yellow
          case "blue": return blue
          case "magenta": return magenta
          case "cyan": return cyan
          case "white": return white
          case "brightBlack": return brightBlack
          case "brightRed": return brightRed
          case "brightGreen": return brightGreen
          case "brightYellow": return brightYellow
          case "brightBlue": return brightBlue
          case "brightMagenta": return brightMagenta
          case "brightCyan": return brightCyan
          case "brightWhite": return brightWhite
          default: fatalError("Invalid key")
        }
      }
      set
      {
        switch key
        {
          case "text": text = newValue
          case "boldText": boldText = newValue
          case "cursor": cursor = newValue
          case "background": background = newValue
          case "selection": selection = newValue
          case "black": black = newValue
          case "red": red = newValue
          case "green": green = newValue
          case "yellow": yellow = newValue
          case "blue": blue = newValue
          case "magenta": magenta = newValue
          case "cyan": cyan = newValue
          case "white": white = newValue
          case "brightBlack": brightBlack = newValue
          case "brightRed": brightRed = newValue
          case "brightGreen": brightGreen = newValue
          case "brightYellow": brightYellow = newValue
          case "brightBlue": brightBlue = newValue
          case "brightMagenta": brightMagenta = newValue
          case "brightCyan": brightCyan = newValue
          case "brightWhite": brightWhite = newValue
          default: fatalError("Invalid key")
        }
      }
    }

    init(
      text: Attributes,
      boldText: Attributes,
      cursor: Attributes,
      background: Attributes,
      selection: Attributes,
      black: Attributes,
      red: Attributes,
      green: Attributes,
      yellow: Attributes,
      blue: Attributes,
      magenta: Attributes,
      cyan: Attributes,
      white: Attributes,
      brightBlack: Attributes,
      brightRed: Attributes,
      brightGreen: Attributes,
      brightYellow: Attributes,
      brightBlue: Attributes,
      brightMagenta: Attributes,
      brightCyan: Attributes,
      brightWhite: Attributes
    )
    {
      self.text = text
      self.boldText = boldText
      self.cursor = cursor
      self.background = background
      self.selection = selection
      self.black = black
      self.red = red
      self.green = green
      self.yellow = yellow
      self.blue = blue
      self.magenta = magenta
      self.cyan = cyan
      self.white = white
      self.brightBlack = brightBlack
      self.brightRed = brightRed
      self.brightGreen = brightGreen
      self.brightYellow = brightYellow
      self.brightBlue = brightBlue
      self.brightMagenta = brightMagenta
      self.brightCyan = brightCyan
      self.brightWhite = brightWhite
    }
  }
}
