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

/*
 The object of this class intended to be a hearth of command palette. This object only exists as singleton.
  In Order to access its instance use `CommandManager.shared`

 ```
  /* To add or execute command see snipper below */
 let mgr = CommandManager.shared
 let wrap = CommandClosureWrapper.init(closure: {
     print("testing closure")
 })

 mgr.addCommand(name: "test", command: wrap)
 mgr.executeCommand(name: "test")
  ```
  */

final class CommandManager: ObservableObject
{
  @Published private var commandsList: [String: Command]

  private init()
  {
    commandsList = [:]
  }

  static let shared: CommandManager = .init()

  func addCommand(name: String, title: String, id: String, command: CommandClosureWrapper)
  {
    let command = Command(id: name, title: title, closureWrapper: command)
    commandsList[id] = command
  }

  var commands: [Command]
  {
    commandsList.map(\.value)
  }

  func executeCommand(name: String)
  {
    commandsList[name]?.closureWrapper.call()
  }
}

/// Command struct uses as a wrapper for command. Used by command palette to call selected commands.
struct Command: Identifiable, Hashable
{
  static func == (lhs: Command, rhs: Command) -> Bool
  {
    lhs.id == rhs.id
  }

  static func < (_: Command, _: Command) -> Bool
  {
    false
  }

  func hash(into hasher: inout Hasher)
  {
    hasher.combine(id)
  }

  let id: String
  let title: String
  let closureWrapper: CommandClosureWrapper
  init(id: String, title: String, closureWrapper: CommandClosureWrapper)
  {
    self.id = id
    self.title = title
    self.closureWrapper = closureWrapper
  }
}

/// A simple wrapper for command closure
struct CommandClosureWrapper
{
  /// A typealias of interface used for command closure declaration
  typealias WorkspaceClientClosure = () -> Void

  let workspaceClientClosure: WorkspaceClientClosure?

  /// Initializer for closure wrapper
  /// - Parameter closure: Function that contains all logic to run command.
  init(closure: @escaping WorkspaceClientClosure)
  {
    workspaceClientClosure = closure
  }

  func call()
  {
    workspaceClientClosure?()
  }
}
