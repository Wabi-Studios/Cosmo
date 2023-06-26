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

struct HelpCommands: Commands
{
  var body: some Commands
  {
    CommandGroup(after: .help)
    {
      Button("What's New in Cosmo")
      {}
      .disabled(true)

      Button("Release Notes")
      {}
      .disabled(true)

      Button("Report an Issue")
      {
        NSApp.sendAction(#selector(AppDelegate.openFeedback(_:)), to: nil, from: nil)
      }
    }
  }
}
