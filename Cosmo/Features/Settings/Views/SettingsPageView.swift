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

struct SettingsPageView: View
{
  var page: SettingsPage

  init(_ page: SettingsPage)
  {
    self.page = page
  }

  var body: some View
  {
    NavigationLink(value: page)
    {
      Label
      {
        Text(page.nameString)
          .padding(.leading, 2)
      } icon: {
        if let icon = page.icon
        {
          Group
          {
            switch icon
            {
              case let .system(name):
                Image(systemName: name)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              case let .symbol(name):
                Image(symbol: name)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              case let .asset(name):
                Image(name)
                  .resizable()
                  .aspectRatio(contentMode: .fit)
            }
          }
          .shadow(color: Color(NSColor.black).opacity(0.25), radius: 0.5, y: 0.5)
          .padding(2.5)
          .foregroundColor(.white)
          .frame(width: 20, height: 20)
          .background(
            RoundedRectangle(
              cornerRadius: 5,
              style: .continuous
            )
            .fill(page.baseColor.gradient)
            .shadow(color: Color(NSColor.black).opacity(0.25), radius: 0.5, y: 0.5)
          )
        }
        else
        {
          EmptyView()
        }
      }
    }
  }
}
