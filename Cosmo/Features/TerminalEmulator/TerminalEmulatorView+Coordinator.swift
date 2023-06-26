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

import SwiftTerm
import SwiftUI

extension TerminalEmulatorView
{
  final class Coordinator: NSObject, LocalProcessTerminalViewDelegate
  {
    @State
    private var url: URL

    init(url: URL)
    {
      _url = .init(wrappedValue: url)
      super.init()
    }

    func hostCurrentDirectoryUpdate(source _: TerminalView, directory _: String?) {}

    func sizeChanged(source _: LocalProcessTerminalView, newCols _: Int, newRows _: Int) {}

    func setTerminalTitle(source _: LocalProcessTerminalView, title _: String) {}

    func processTerminated(source: TerminalView, exitCode: Int32?)
    {
      guard let exitCode
      else
      {
        return
      }
      source.feed(text: "Exit code: \(exitCode)\n\r\n")
      source.feed(text: "To open a new session close and reopen the terminal drawer")
      TerminalEmulatorView.lastTerminal[url.path] = nil
    }
  }
}
