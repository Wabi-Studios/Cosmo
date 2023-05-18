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

import Foundation
import SwiftUI

@propertyWrapper
struct AppSettings<T>: DynamicProperty where T: Equatable
{
  var settings: Environment<T>

  let keyPath: WritableKeyPath<SettingsData, T>

  @available(*,
             deprecated,
             message: """
             Use init(_ keyPath:) instead, otherwise the view will be reevaluated on every settings change.
             """)
  init() where T == SettingsData
  {
    keyPath = \.self
    settings = .init(\.settings)
  }

  init(_ keyPath: WritableKeyPath<SettingsData, T>)
  {
    self.keyPath = keyPath
    let newKeyPath = (\EnvironmentValues.settings).appending(path: keyPath)
    settings = .init(newKeyPath)
  }

  var wrappedValue: T
  {
    get
    {
      settings.wrappedValue
    }
    nonmutating set
    {
      Settings.shared.preferences[keyPath: keyPath] = newValue
    }
  }

  var projectedValue: Binding<T>
  {
    .init
    {
      settings.wrappedValue
    } set: {
      Settings.shared.preferences[keyPath: keyPath] = $0
    }
  }
}

struct SettingsDataEnvironmentKey: EnvironmentKey
{
  static var defaultValue: SettingsData = .init()
}

extension EnvironmentValues
{
  var settings: SettingsDataEnvironmentKey.Value
  {
    get { self[SettingsDataEnvironmentKey.self] }
    set { self[SettingsDataEnvironmentKey.self] = newValue }
  }
}
