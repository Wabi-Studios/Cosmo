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

struct TabBarItemButtonStyle: ButtonStyle
{
  @Environment(\.colorScheme)
  var colorScheme

  @Binding
  private var isPressing: Bool

  init(isPressing: Binding<Bool>)
  {
    _isPressing = isPressing
  }

  func makeBody(configuration: Configuration) -> some View
  {
    configuration.label
      .onChange(of: configuration.isPressed, perform: { isPressed in
        isPressing = isPressed
      })
  }
}
