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

struct WindowCommands: Commands
{
  @Environment(\.openWindow) var openWindow

  var body: some Commands
  {
    CommandGroup(after: .windowArrangement)
    {
      // This command is used to open SwiftUI windows from AppKit.
      // It should not be used by the user.
      // This menu item will be hidden (see WindowCommands/Utils/CommandsFixes.swift)
      Button("OpenWindowAction")
      {
        guard let result = NSMenuItem.openWindowAction?()
        else
        {
          return
        }
        switch result
        {
          case let (.some(id), .none):
            openWindow(id: id.rawValue)
          case let (.none, .some(data)):
            openWindow(value: data)
          case let (.some(id), .some(data)):
            openWindow(id: id.rawValue, value: data)
          default:
            break
        }
      }
    }
  }
}
