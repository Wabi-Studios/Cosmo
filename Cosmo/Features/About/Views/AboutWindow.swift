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

struct AboutWindow: Scene
{
  var body: some Scene
  {
    Window("", id: SceneID.about.rawValue)
    {
      AboutView()
    }
    .defaultSize(width: 530, height: 220)
    .windowResizability(.contentSize)
    .windowStyle(.hiddenTitleBar)
  }
}
