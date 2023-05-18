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

import CodeEditSymbols
import SwiftUI

struct StatusBarMenuStyle: MenuStyle
{
  @Environment(\.controlActiveState)
  private var controlActive

  @Environment(\.colorScheme)
  private var colorScheme

  func makeBody(configuration: Configuration) -> some View
  {
    Menu(configuration)
      .controlSize(.small)
      .menuStyle(.borderlessButton)
      .opacity(controlActive == .inactive
        ? colorScheme == .dark ? 0.66 : 1
        : colorScheme == .dark ? 0.54 : 0.72)
      .fixedSize()
  }
}

extension MenuStyle where Self == StatusBarMenuStyle
{
  static var statusBar: StatusBarMenuStyle { .init() }
}
