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

struct InspectorField<Content: View>: View
{
  var label: String
  let content: Content

  init(_ label: String, @ViewBuilder _ content: () -> Content)
  {
    self.label = label
    self.content = content()
  }

  var body: some View
  {
    HStack(alignment: .top, spacing: 5)
    {
      Text(label)
        .foregroundColor(.primary)
        .fontWeight(.regular)
        .font(.system(size: 10))
        .padding(.top, 3)
        .frame(maxWidth: 72, alignment: .trailing)
      VStack(alignment: .leading)
      {
        content
      }
      .frame(maxWidth: .infinity)
    }
  }
}

struct InspectorField_Previews: PreviewProvider
{
  static var previews: some View
  {
    InspectorField("Section Label")
    {
      Text("Preview")
    }
  }
}
