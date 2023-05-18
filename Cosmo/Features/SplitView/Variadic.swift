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

struct Helper<Result: View>: _VariadicView_UnaryViewRoot
{
  // swiftlint:disable:next identifier_name
  var _body: (_VariadicView.Children) -> Result

  func body(children: _VariadicView.Children) -> some View
  {
    _body(children)
  }
}

extension View
{
  /// Exposes the children of a ViewBuilder so they can be accessed individually.
  func variadic(@ViewBuilder process: @escaping (_VariadicView.Children) -> some View) -> some View
  {
    _VariadicView.Tree(Helper(_body: process), content: { self })
  }
}
