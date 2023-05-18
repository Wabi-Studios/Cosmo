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

/// A `NSTableCellView` showing an icon and label
final class FindNavigatorListMatchCell: NSTableCellView
{
  private var label: NSTextField!
  private var icon: NSImageView!
  private var matchItem: SearchResultMatchModel

  init(frame: CGRect, matchItem: SearchResultMatchModel)
  {
    self.matchItem = matchItem
    super.init(frame: CGRect(
      x: frame.origin.x,
      y: frame.origin.y,
      width: frame.width,
      height: CGFloat.greatestFiniteMagnitude
    ))

    // Create the label
    setUpLabel()
    setLabelString()

    addSubview(label)

    // Create the icon

    setUpImageView()

    addSubview(icon)
    imageView = icon

    // Constraints

    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 4),
      label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2),
      label.topAnchor.constraint(equalTo: topAnchor, constant: 4),
      label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),

      icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: -2),
      icon.topAnchor.constraint(equalTo: label.topAnchor, constant: 2),
      icon.widthAnchor.constraint(equalToConstant: 16),
      icon.heightAnchor.constraint(equalToConstant: 16),
    ])
  }

  /// Sets up the `NSTextField` used as a label in the cell.
  /// - Parameter frame: The frame the cell should use.
  private func setUpLabel()
  {
    label = NSTextField(wrappingLabelWithString: matchItem.lineContent)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.drawsBackground = false
    label.isEditable = false
    label.isSelectable = false
    label.layer?.cornerRadius = 10.0
    label.font = .labelFont(ofSize: 13)
    label.allowsDefaultTighteningForTruncation = false
    label.cell?.truncatesLastVisibleLine = true
    label.cell?.wraps = true
    label.maximumNumberOfLines = 3
  }

  /// Sets up the image view for the search result.
  private func setUpImageView()
  {
    icon = NSImageView(frame: .zero)
    icon.translatesAutoresizingMaskIntoConstraints = false
    icon.symbolConfiguration = .init(
      pointSize: 13,
      weight: .regular,
      scale: .medium
    )
    icon.image = NSImage(systemSymbolName: "text.alignleft", accessibilityDescription: nil)
    icon.contentTintColor = NSColor.secondaryLabelColor
  }

  /// Sets the attributed string for the search result with correct paragraph break mode,
  /// styling, font, etc.
  private func setLabelString()
  {
    label.attributedStringValue = matchItem.attributedLabel()
  }

  @available(*, unavailable)
  required init?(coder _: NSCoder)
  {
    fatalError()
  }
}
