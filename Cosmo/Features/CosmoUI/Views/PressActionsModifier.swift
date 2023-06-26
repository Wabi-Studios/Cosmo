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

struct PressActions: ViewModifier
{
  var onPress: () -> Void
  var onRelease: () -> Void

  init(onPress: @escaping () -> Void, onRelease: @escaping () -> Void)
  {
    self.onPress = onPress
    self.onRelease = onRelease
  }

  func body(content: Content) -> some View
  {
    content
      .simultaneousGesture(
        DragGesture(minimumDistance: 0)
          .onChanged
          { _ in
            onPress()
          }
          .onEnded
          { _ in
            onRelease()
          }
      )
  }
}

extension View
{
  /// A custom view modifier for press actions with callbacks for `onPress` and `onRelease`.
  /// - Parameters:
  ///   - onPress: Action to perform once the view is pressed.
  ///   - onRelease: Action to perform once the view press is released.
  /// - Returns: some View
  func pressAction(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View
  {
    modifier(PressActions(onPress: {
      onPress()
    }, onRelease: {
      onRelease()
    }))
  }
}
