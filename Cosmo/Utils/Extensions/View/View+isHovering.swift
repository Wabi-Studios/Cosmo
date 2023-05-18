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

extension View
{
  /// Changes the cursor appearance when hovering attached View
  /// - Parameters:
  ///   - active: onHover() value
  ///   - isDragging: indicate that dragging is happening. If true this will not change the cursor.
  ///   - cursor: the cursor to display on hover
  func isHovering(_ active: Bool, isDragging: Bool = false, cursor: NSCursor = .arrow)
  {
    if isDragging { return }
    if active
    {
      cursor.push()
    }
    else
    {
      NSCursor.pop()
    }
  }
}
