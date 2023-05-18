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

/// Accessory icon's view for tab bar.
struct TabBarAccessoryIcon: View
{
  /// Unifies icon font for tab bar accessories.
  static let iconFont = Font.system(size: 14, weight: .regular, design: .default)

  private let icon: Image
  private let action: () -> Void

  init(icon: Image, action: @escaping () -> Void)
  {
    self.icon = icon
    self.action = action
  }

  var body: some View
  {
    Button(
      action: action,
      label: { icon }
    )
    .buttonStyle(.icon(size: 24))
  }
}

/// Tab bar accessory area background for native tab bar style.
struct TabBarAccessoryNativeBackground: View
{
  enum DividerPosition
  {
    case none
    case leading
    case trailing
  }

  /// Divider alignment
  private let dividerPosition: Self.DividerPosition

  init(dividerAt: Self.DividerPosition)
  {
    dividerPosition = dividerAt
  }

  private func getAlignment() -> Alignment
  {
    switch dividerPosition
    {
      case .leading:
        return .leading
      case .trailing:
        return .trailing
      default:
        return .leading
    }
  }

  private func getPaddingDirection() -> Edge.Set
  {
    switch dividerPosition
    {
      case .leading:
        return .leading
      case .trailing:
        return .trailing
      default:
        return .leading
    }
  }

  var body: some View
  {
    ZStack(alignment: getAlignment())
    {
      TabBarNativeInactiveBackgroundColor()
        .padding(getPaddingDirection(), dividerPosition == .none ? 0 : 1)
      TabDivider()
        .opacity(dividerPosition == .none ? 0 : 1)
      TabBarTopDivider()
        .frame(maxHeight: .infinity, alignment: .top)
    }
  }
}
