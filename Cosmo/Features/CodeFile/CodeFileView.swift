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

import CodeEditLanguages
import CodeEditTextView
import Combine
import Foundation
import SwiftUI

/// CodeFileView is just a wrapper of the `CodeEditor` dependency
struct CodeFileView: View
{
  @ObservedObject
  private var codeFile: CodeFileDocument

  @AppSettings(\.textEditing.defaultTabWidth) var defaultTabWidth
  @AppSettings(\.textEditing.lineHeightMultiple) var lineHeightMultiple
  @AppSettings(\.textEditing.letterSpacing) var letterSpacing
  @AppSettings(\.textEditing.wrapLinesToEditorWidth) var wrapLinesToEditorWidth
  @AppSettings(\.textEditing.font) var settingsFont
  @AppSettings(\.theme.useThemeBackground) var useThemeBackground
  @AppSettings(\.theme.matchAppearance) var matchAppearance

  @Environment(\.colorScheme)
  private var colorScheme

  @StateObject
  private var themeModel: ThemeModel = .shared

  private var cancellables = [AnyCancellable]()

  private let isEditable: Bool

  init(codeFile: CodeFileDocument, isEditable: Bool = true)
  {
    self.codeFile = codeFile
    self.isEditable = isEditable

    codeFile
      .$content
      .dropFirst()
      .debounce(
        for: 0.25,
        scheduler: DispatchQueue.main
      )
      .sink
      { _ in
        codeFile.autosave(withImplicitCancellability: false)
        { _ in
        }
      }
      .store(in: &cancellables)

    codeFile
      .$content
      .dropFirst()
      .sink
      { _ in
        codeFile.updateChangeCount(.changeDone)
      }
      .store(in: &cancellables)
  }

  @State
  private var selectedTheme = ThemeModel.shared.selectedTheme ?? ThemeModel.shared.themes.first!

  @State
  private var font: NSFont = {
    Settings[\.textEditing].font.current()
  }()

  @Environment(\.edgeInsets)
  private var edgeInsets

  @EnvironmentObject
  private var tabgroup: TabGroupData

  var body: some View
  {
    CodeEditTextView(
      $codeFile.content,
      language: getLanguage(),
      theme: selectedTheme.editor.editorTheme,
      font: font,
      tabWidth: defaultTabWidth,
      lineHeight: lineHeightMultiple,
      wrapLines: wrapLinesToEditorWidth,
      cursorPosition: $codeFile.cursorPosition,
      useThemeBackground: useThemeBackground,
      contentInsets: edgeInsets.nsEdgeInsets,
      isEditable: isEditable,
      letterSpacing: letterSpacing
    )
    .id(codeFile.fileURL)
    .background
    {
      if colorScheme == .dark
      {
        EffectView(.underPageBackground)
      }
      else
      {
        EffectView(.contentBackground)
      }
    }
    .colorScheme(
      selectedTheme.appearance == .dark
        ? .dark
        : .light
    )
    // minHeight zero fixes a bug where the app would freeze if the contents of the file are empty.
    .frame(minHeight: .zero, maxHeight: .infinity)
    .onChange(of: themeModel.selectedTheme)
    { newValue in
      guard let theme = newValue else { return }
      selectedTheme = theme
    }
    .onChange(of: colorScheme)
    { newValue in
      if matchAppearance
      {
        themeModel.selectedTheme = newValue == .dark
          ? themeModel.selectedDarkTheme
          : themeModel.selectedLightTheme
      }
    }
    .onChange(of: settingsFont)
    { _ in
      font = Settings.shared.preferences.textEditing.font.current()
    }
  }

  private func getLanguage() -> CodeLanguage
  {
    guard let url = codeFile.fileURL
    else
    {
      return .default
    }
    return .detectLanguageFrom(url: url)
  }
}
