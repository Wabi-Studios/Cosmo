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

struct SettingsColorPicker: View
{
  @Binding var color: Color

  private let label: String

  init(_ label: String, color: Binding<Color>)
  {
    _color = color
    self.label = label
  }

  var body: some View
  {
    LabeledContent(label)
    {
      ColorPicker(selection: $color, supportsOpacity: false) {}
        .labelsHidden()
    }
  }
}
