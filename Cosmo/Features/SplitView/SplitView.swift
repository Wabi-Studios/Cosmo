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

struct SplitView<Content: View>: View
{
  var axis: Axis
  var content: Content

  init(axis: Axis, @ViewBuilder content: () -> Content)
  {
    self.axis = axis
    self.content = content()
  }

  @State var viewController: () -> SplitViewController? = { nil }

  var body: some View
  {
    VStack
    {
      content.variadic
      { children in
        SplitViewControllerView(axis: axis, children: children, viewController: $viewController)
      }
    }
    ._trait(SplitViewControllerLayoutValueKey.self, viewController)
  }
}
