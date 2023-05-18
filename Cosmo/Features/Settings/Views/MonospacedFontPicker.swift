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

struct MonospacedFontPicker: View
{
  var title: String
  @Binding var selectedFontName: String
  @State var recentFonts: [String]
  @State var monospacedFontFamilyNames: [String] = []
  @State var otherFontFamilyNames: [String] = []

  init(title: String, selectedFontName: Binding<String>)
  {
    self.title = title
    _selectedFontName = selectedFontName
    recentFonts = UserDefaults.standard.stringArray(forKey: "recentFonts") ?? []
  }

  private func pushIntoRecentFonts(_ newItem: String)
  {
    recentFonts.removeAll(where: { $0 == newItem })
    recentFonts.insert(newItem, at: 0)
    if recentFonts.count > 3
    {
      recentFonts.removeLast()
    }
    UserDefaults.standard.set(recentFonts, forKey: "recentFonts")
  }

  func getFonts()
  {
    DispatchQueue.global(qos: .userInitiated).async
    {
      let availableFontFamilies = NSFontManager.shared.availableFontFamilies

      monospacedFontFamilyNames = availableFontFamilies.filter
      { fontFamilyName in
        let fontNames = NSFontManager.shared.availableMembers(ofFontFamily: fontFamilyName) ?? []
        return fontNames.contains
        { fontName in
          guard let font = NSFont(name: "\(fontName[0])", size: 14)
          else
          {
            return false
          }
          return font.isFixedPitch && font.numberOfGlyphs > 26
        }
      }
      .filter { $0 != "FiraCode NF" }

      otherFontFamilyNames = availableFontFamilies.filter
      { fontFamilyName in
        let fontNames = NSFontManager.shared.availableMembers(ofFontFamily: fontFamilyName) ?? []
        return fontNames.contains
        { fontName in
          guard let font = NSFont(name: "\(fontName[0])", size: 14)
          else
          {
            return false
          }
          return !font.isFixedPitch && font.numberOfGlyphs > 26
        }
      }
    }
  }

  var body: some View
  {
    Picker(selection: $selectedFontName, label: Text(title))
    {
      Text("System Font")
        .font(Font(NSFont.monospacedSystemFont(ofSize: 13.5, weight: .medium)))
        .tag("FiraCode NF")
      if !recentFonts.isEmpty
      {
        Divider()
        ForEach(recentFonts, id: \.self)
        { fontFamilyName in
          Text(fontFamilyName).font(.custom(fontFamilyName, size: 13.5))
        }
      }
      if !monospacedFontFamilyNames.isEmpty
      {
        Divider()
        ForEach(monospacedFontFamilyNames, id: \.self)
        { fontFamilyName in
          Text(fontFamilyName).font(.custom(fontFamilyName, size: 13.5))
        }
      }
      if !otherFontFamilyNames.isEmpty
      {
        Divider()
        Picker(selection: $selectedFontName, label: Text("Other fonts..."))
        {
          ForEach(otherFontFamilyNames, id: \.self)
          { fontFamilyName in
            Text(fontFamilyName)
              .font(.custom(fontFamilyName, size: 13.5))
          }
        }
      }
    }
    .onChange(of: selectedFontName)
    { selection in
      if selectedFontName != "FiraCode NF"
      {
        pushIntoRecentFonts(selection)
      }
    }
    .onAppear(perform: getFonts)
  }
}
