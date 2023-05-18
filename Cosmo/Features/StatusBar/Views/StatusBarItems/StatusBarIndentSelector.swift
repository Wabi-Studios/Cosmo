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

struct StatusBarIndentSelector: View
{
  @AppSettings(\.textEditing.defaultTabWidth) var defaultTabWidth

  var body: some View
  {
    Menu
    {
      Button {} label: {
        Text("Use Tabs")
      }.disabled(true)

      Button {} label: {
        Text("Use Spaces")
      }.disabled(true)

      Divider()

      Picker("Tab Width", selection: $defaultTabWidth)
      {
        ForEach(2 ..< 9)
        { index in
          Text("\(index) Spaces")
            .tag(index)
        }
      }
    } label: {
      Text("\(defaultTabWidth) Spaces")
    }
    .menuStyle(StatusBarMenuStyle())
    .onHover { isHovering($0) }
  }
}
