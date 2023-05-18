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

struct CosmoCommands: Commands
{
  var body: some Commands
  {
    MainCommands()
    FileCommands()
    ViewCommands()
    FindCommands()
    NavigateCommands()
    SourceControlCommands()
    WindowCommands()
    HelpCommands()
  }
}
