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

/// A property wrapper which allows for easy access to the current first responder.
/// This differs from the SwiftUI Focus System, as you get AppKit NSResponders, which you can call methods on.
/// It can also be easily checked if the current first selector accepts some event.
@propertyWrapper
struct FirstResponder: DynamicProperty
{
  @StateObject var helper = HelperClass()

  var wrappedValue: NSResponder?
  {
    helper.responder
  }

  class HelperClass: ObservableObject
  {
    @Published var responder: NSResponder? = NSApp.keyWindow?.firstResponder

    init()
    {
      NSApp.publisher(for: \.keyWindow?.firstResponder).assign(to: &$responder)
    }
  }
}
