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

struct AccountSelectionView: View
{
  @Environment(\.dismiss) var dismiss

  @Binding var selectedProvider: SourceControlAccount.Provider?

  var gitProviders = SourceControlAccount.Provider.allCases

  var body: some View
  {
    VStack(spacing: 0)
    {
      Form
      {
        Section
        {
          VStack(alignment: .leading, spacing: 0)
          {
            ForEach(gitProviders, id: \.self)
            { provider in
              AccountsSettingsProviderRow(
                name: provider.name,
                iconName: provider.iconName,
                action: {
                  selectedProvider = provider
                  dismiss()
                }
              )
              Divider()
            }
          }
          .padding(-10)
        } footer: {
          HStack
          {
            Spacer()
            Button
            {
              dismiss()
            } label: {
              Text("Cancel")
                .padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
          }
          .padding(.top, 10)
        }
      }
      .formStyle(.grouped)
      .scrollDisabled(true)
    }
    .frame(width: 300)
  }
}
