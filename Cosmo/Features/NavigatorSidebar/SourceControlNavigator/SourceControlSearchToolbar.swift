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

struct SourceControlSearchToolbar: View
{
  @Environment(\.colorScheme)
  var colorScheme

  @Environment(\.controlActiveState)
  private var controlActive

  @State
  private var text = ""

  var body: some View
  {
    HStack
    {
      Image(systemName: "line.3.horizontal.decrease.circle")
        .foregroundColor(.secondary)
      textField
      if !text.isEmpty { clearButton }
    }
    .padding(.horizontal, 5)
    .padding(.vertical, 3)
    .background(.ultraThinMaterial)
    .clipShape(RoundedRectangle(cornerRadius: 6))
    .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.gray, lineWidth: 0.5).cornerRadius(6))
  }

  private var textField: some View
  {
    TextField("Filter", text: $text)
      .disableAutocorrection(true)
      .textFieldStyle(PlainTextFieldStyle())
  }

  private var clearButton: some View
  {
    Button
    {
      text = ""
    } label: {
      Image(systemName: "xmark.circle.fill")
    }
    .foregroundColor(.secondary)
    .buttonStyle(PlainButtonStyle())
  }
}
