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

/// Native style background view (including color and shadow divider) for tab bar.
struct TabBarNativeInactiveBackground: View
{
  var body: some View
  {
    ZStack(alignment: .top)
    {
      TabBarNativeInactiveBackgroundColor()
      // When tab bar style is `native`, we put the top divider beneath tabs.
      TabBarTopDivider()
    }
  }
}

/// Native style background color for tab bar.
struct TabBarNativeInactiveBackgroundColor: View
{
  @Environment(\.colorScheme)
  private var colorScheme

  var body: some View
  {
    Color(nsColor: .black)
      .opacity(colorScheme == .dark ? 0.45 : 0.05)
  }
}

/// Native style background material for active tab bar in fullscreen.
/// This view is only used in fullscreen (to match the material of toolbar).
struct TabBarNativeActiveMaterial: View
{
  @Environment(\.colorScheme)
  private var colorScheme

  var body: some View
  {
    EffectView(
      NSVisualEffectView.Material.headerView,
      blendingMode: NSVisualEffectView.BlendingMode.withinWindow
    )
    .background(
      // This layer of background is for matching the native toolbar background
      // in dark mode and in fullscreen.
      // There is no exactly matched material available.
      // If you have a better solution, feel free to replace!!
      Color(nsColor: colorScheme == .dark ? .selectedContentBackgroundColor : .clear)
        .opacity(0.003)
    )
    .background(
      Color(nsColor: .windowBackgroundColor)
    )
  }
}

/// Native style background material for tab bar.
struct TabBarNativeMaterial: View
{
  var body: some View
  {
    EffectView(
      NSVisualEffectView.Material.titlebar,
      blendingMode: NSVisualEffectView.BlendingMode.withinWindow
    )
    .background(Color(nsColor: .windowBackgroundColor))
  }
}
