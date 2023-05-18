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

struct AccountsSettingsView: View
{
  @AppSettings(\.accounts.sourceControlAccounts.gitAccounts) var gitAccounts

  @State private var addAccountSheetPresented: Bool = false
  @State private var selectedProvider: SourceControlAccount.Provider?

  var body: some View
  {
    SettingsForm
    {
      Section
      {
        if $gitAccounts.isEmpty
        {
          Text("No accounts")
            .foregroundColor(.secondary)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        else
        {
          ForEach($gitAccounts, id: \.self)
          { $account in
            AccountsSettingsAccountLink($account)
          }
        }
      } footer: {
        HStack
        {
          Spacer()
          Button("Add Account...") { addAccountSheetPresented.toggle() }
            .sheet(isPresented: $addAccountSheetPresented, content: {
              AccountSelectionView(selectedProvider: $selectedProvider)
            })
            .sheet(item: $selectedProvider, content: { provider in
              switch provider
              {
                case .github, .githubEnterprise, .gitlab, .gitlabSelfHosted:
                  AccountsSettingsSigninView(provider, addAccountSheetPresented: $addAccountSheetPresented)
                default:
                  implementationNeeded
              }
            })
        }
        .padding(.top, 10)
      }
    }
  }

  private var implementationNeeded: some View
  {
    VStack(spacing: 20)
    {
      Text("This git client is currently not supported.")
      HStack
      {
        Button("Close")
        {
          addAccountSheetPresented.toggle()
          selectedProvider = nil
        }
        .buttonStyle(.borderedProminent)
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
    .padding(20)
  }
}
