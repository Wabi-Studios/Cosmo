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

import SwiftUI

struct FindNavigatorSearchBar: View
{
  @Environment(\.colorScheme)
  var colorScheme

  @ObservedObject
  private var state: WorkspaceDocument.SearchState

  @FocusState
  private var isFocused: Bool

  private let title: String

  @Binding
  private var text: String

  @Environment(\.controlActiveState)
  private var controlActive

  @ViewBuilder
  public func selectionBackground(
    _ isFocused: Bool = false
  ) -> some View
  {
    if controlActive != .inactive
    {
      if isFocused
      {
        if colorScheme == .light
        {
          Color.white
        }
        else
        {
          Color(hex: 0x1E1E1E)
        }
      }
      else
      {
        if colorScheme == .light
        {
          Color.black.opacity(0.06)
        }
        else
        {
          Color.white.opacity(0.24)
        }
      }
    }
    else
    {
      if colorScheme == .light
      {
        Color.clear
      }
      else
      {
        Color.white.opacity(0.14)
      }
    }
  }

  init(
    state: WorkspaceDocument.SearchState,
    title: String,
    text: Binding<String>
  )
  {
    self.state = state
    self.title = title
    _text = text
  }

  var body: some View
  {
    HStack
    {
      Image(systemName: "magnifyingglass")
        .foregroundColor(Color(nsColor: .secondaryLabelColor))
      textField
      if !text.isEmpty { clearButton }
    }
    .padding(.horizontal, 5)
    .padding(.vertical, 3)
    .background(selectionBackground(isFocused))
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.5).cornerRadius(6))
  }

  private var textField: some View
  {
    TextField(title, text: $text)
      .disableAutocorrection(true)
      .textFieldStyle(PlainTextFieldStyle())
      .focused($isFocused)
  }

  private var clearButton: some View
  {
    Button
    {
      text = ""
      state.search(nil)
    } label: {
      Image(systemName: "xmark.circle.fill")
    }
    .foregroundColor(.secondary)
    .buttonStyle(PlainButtonStyle())
  }
}
