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

extension String
{
  func localized(_ custom: String? = nil) -> LocalizedStringKey
  {
    if let custom
    {
      return LocalizedStringKey(custom)
    }
    else
    {
      return LocalizedStringKey(self)
    }
  }
}

extension LocalizedStringKey
{
  static let helloWorld = "Hello, world!".localized()
}
