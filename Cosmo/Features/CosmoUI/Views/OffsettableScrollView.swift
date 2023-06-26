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

private struct ScrollViewOffsetPreferenceKey: PreferenceKey
{
  static var defaultValue: CGPoint = .zero

  static func reduce(value _: inout CGPoint, nextValue _: () -> CGPoint) {}
}

struct OffsettableScrollView<T: View>: View
{
  let axes: Axis.Set
  let showsIndicator: Bool
  let onOffsetChanged: (CGPoint) -> Void
  let content: T

  init(
    axes: Axis.Set = .vertical,
    showsIndicator: Bool = true,
    onOffsetChanged: @escaping (CGPoint) -> Void = { _ in },
    @ViewBuilder content: () -> T
  )
  {
    self.axes = axes
    self.showsIndicator = showsIndicator
    self.onOffsetChanged = onOffsetChanged
    self.content = content()
  }

  var body: some View
  {
    ScrollView(axes, showsIndicators: showsIndicator)
    {
      GeometryReader
      { proxy in
        Color.clear.preference(
          key: ScrollViewOffsetPreferenceKey.self,
          value: proxy.frame(
            in: .named("ScrollViewOrigin")
          ).origin
        )
      }
      .frame(width: 0, height: 0)
      content
    }
    .coordinateSpace(name: "ScrollViewOrigin")
    .onPreferenceChange(
      ScrollViewOffsetPreferenceKey.self,
      perform: onOffsetChanged
    )
  }
}
