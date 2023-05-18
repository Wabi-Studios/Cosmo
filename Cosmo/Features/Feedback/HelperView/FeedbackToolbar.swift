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

struct FeedbackToolbar<T: View>: View
{
  private var content: () -> T

  init(
    bgColor _: Color = Color(NSColor.controlBackgroundColor),
    @ViewBuilder content: @escaping () -> T
  )
  {
    self.content = content
  }

  var body: some View
  {
    ZStack
    {
      HStack
      {
        content()
          .padding(.horizontal, 8)
      }
    }
  }
}
