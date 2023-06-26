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

struct WelcomeActionView: View
{
  var iconName: String
  var title: String
  var subtitle: String

  init(iconName: String, title: String, subtitle: String)
  {
    self.iconName = iconName
    self.title = title
    self.subtitle = subtitle
  }

  var body: some View
  {
    HStack(spacing: 16)
    {
      Image(systemName: iconName)
        .aspectRatio(contentMode: .fit)
        .foregroundColor(.accentColor)
        .font(.system(size: 30, weight: .light))
        .frame(width: 24)
      VStack(alignment: .leading)
      {
        Text(title)
          .bold()
          .font(.system(size: 13))
        Text(subtitle)
          .font(.system(size: 12))
      }
      Spacer()
    }
    .contentShape(Rectangle())
  }
}
