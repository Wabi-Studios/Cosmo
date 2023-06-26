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

struct AccountsSettingsAccountLink: View
{
  @Binding var account: SourceControlAccount

  init(_ account: Binding<SourceControlAccount>)
  {
    _account = account
  }

  var body: some View
  {
    NavigationLink(destination: AccountsSettingsDetailsView($account))
    {
      Label
      {
        Text(account.description)
        Text(account.name)
          .font(.footnote)
          .foregroundColor(.secondary)
      } icon: {
        Image(account.provider.iconName)
          .resizable()
          .aspectRatio(contentMode: .fill)
          .cornerRadius(6)
          .frame(width: 26, height: 26)
          .padding(.top, 2)
          .padding(.bottom, 2)
          .padding(.leading, 2)
      }
    }
  }
}
