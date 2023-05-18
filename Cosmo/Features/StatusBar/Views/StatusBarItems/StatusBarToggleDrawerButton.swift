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

internal struct StatusBarToggleDrawerButton: View
{
  @EnvironmentObject
  private var model: StatusBarViewModel

  @Binding
  var collapsed: Bool

  init(collapsed: Binding<Bool>)
  {
    _collapsed = collapsed
    CommandManager.shared.addCommand(
      name: "Toggle Drawer",
      title: "Toggle Drawer",
      id: "open.drawer",
      command: CommandClosureWrapper(closure: togglePanel)
    )
  }

  func togglePanel()
  {
    withAnimation
    {
      model.isExpanded.toggle()
      collapsed.toggle()
    }
  }

  internal var body: some View
  {
    Button
    {
      togglePanel()
    } label: {
      Image(systemName: "square.bottomthird.inset.filled")
    }
    .buttonStyle(.icon)
    .keyboardShortcut("Y", modifiers: [.command, .shift])
    .onHover { isHovering($0) }
  }
}
