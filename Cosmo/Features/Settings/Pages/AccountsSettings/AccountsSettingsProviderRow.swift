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

struct AccountsSettingsProviderRow: View
{
  var name: String
  var iconName: String
  var action: () -> Void

  @State private var hovering = false
  @State private var pressing = false

  var body: some View
  {
    HStack
    {
      Image(iconName)
        .resizable()
        .aspectRatio(contentMode: .fill)
        .cornerRadius(6)
        .frame(width: 28, height: 28)
      Text(name)
      Spacer()
      if hovering
      {
        Image(systemName: "plus")
          .foregroundColor(Color(.tertiaryLabelColor))
          .padding(.horizontal, 5)
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(10)
    .background(pressing ? Color(nsColor: .quaternaryLabelColor) : Color(nsColor: .clear))
    .overlay(Color(.black).opacity(0.0001))
    .onHover
    { hover in
      hovering = hover
    }
    .pressAction
    {
      pressing = true
    } onRelease: {
      pressing = false
      action()
    }
  }
}
