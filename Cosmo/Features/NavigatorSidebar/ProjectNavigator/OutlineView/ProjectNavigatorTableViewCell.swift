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

protocol OutlineTableViewCellDelegate: AnyObject
{
  func moveFile(file: CEWorkspaceFile, to destination: URL)
  func copyFile(file: CEWorkspaceFile, to destination: URL)
}

/// A `NSTableCellView` showing an ``icon`` and a ``label``
final class ProjectNavigatorTableViewCell: FileSystemTableViewCell
{
  private var delegate: OutlineTableViewCellDelegate?

  /// Initializes the `OutlineTableViewCell` with an `icon` and `label`
  /// Both the icon and label will be colored, and sized based on the user's preferences.
  /// - Parameters:
  ///   - frameRect: The frame of the cell.
  ///   - item: The file item the cell represents.
  ///   - isEditable: Set to true if the user should be able to edit the file name.
  init(
    frame frameRect: NSRect,
    item: CEWorkspaceFile?,
    isEditable: Bool = true,
    delegate: OutlineTableViewCellDelegate? = nil
  )
  {
    super.init(frame: frameRect, item: item, isEditable: isEditable)

    self.delegate = delegate
  }

  /// *Not Implemented*
  override init(frame frameRect: NSRect)
  {
    super.init(frame: frameRect)
    fatalError("""
    init(frame: ) isn't implemented on `OutlineTableViewCell`.
    Please use `.init(frame: NSRect, item: WorkspaceClient.FileItem?)
    """)
  }

  /// *Not Implemented*
  @available(*, unavailable)
  required init?(coder _: NSCoder)
  {
    fatalError("""
    init?(coder: NSCoder) isn't implemented on `OutlineTableViewCell`.
    Please use `.init(frame: NSRect, item: WorkspaceClient.FileItem?)
    """)
  }

  override func controlTextDidEndEditing(_: Notification)
  {
    label.backgroundColor = validateFileName(for: label?.stringValue ?? "") ? .none : errorRed
    if validateFileName(for: label?.stringValue ?? "")
    {
      let destinationURL = fileItem.url
        .deletingLastPathComponent()
        .appendingPathComponent(label?.stringValue ?? "")
      delegate?.moveFile(file: fileItem, to: destinationURL)
    }
    else
    {
      label?.stringValue = fileItem.name
    }
  }
}
