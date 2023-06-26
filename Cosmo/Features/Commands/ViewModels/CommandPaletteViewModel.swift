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

import Foundation

/// Simple state class for command palette view. Contains currently selected command,
/// query text and list of filtered commands
final class CommandPaletteViewModel: ObservableObject
{
  @Published
  var commandQuery: String = ""

  @Published
  var selected: Command?

  @Published
  var isShowingCommandsList: Bool = true

  @Published
  var filteredCommands: [Command] = []

  init() {}

  func reset()
  {
    commandQuery = ""
    selected = nil
    filteredCommands = CommandManager.shared.commands
  }

  func fetchMatchingCommands(val: String)
  {
    if val == ""
    {
      filteredCommands = CommandManager.shared.commands
      return
    }
    filteredCommands = CommandManager.shared.commands.filter { $0.title.localizedCaseInsensitiveContains(val) }
    selected = filteredCommands.first
  }
}
