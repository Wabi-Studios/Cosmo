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

struct AcknowledgementRowView: View
{
  @Environment(\.openURL) private var openURL

  let acknowledgement: AcknowledgementDependency

  var body: some View
  {
    HStack
    {
      Text(acknowledgement.name)
        .font(.body)

      Spacer()

      Button
      {
        openURL(acknowledgement.repositoryURL)
      } label: {
        Image(systemName: "arrow.right.circle.fill")
          .foregroundColor(Color(nsColor: .tertiaryLabelColor))
      }
      .buttonStyle(.plain)
    }
    .padding(.vertical, 12)
    .frame(maxWidth: .infinity)
  }
}

struct AcknowledgementsRowView_Previews: PreviewProvider
{
  static var previews: some View
  {
    AcknowledgementRowView(acknowledgement: AcknowledgementDependency(
      name: "Test",
      repositoryLink: "https://www.test.com/",
      version: "-"
    ))
  }
}
