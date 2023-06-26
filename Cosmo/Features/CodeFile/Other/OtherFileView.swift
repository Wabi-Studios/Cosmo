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

import QuickLookUI
import SwiftUI

/// A SwiftUI Wrapper for `QLPreviewView`
/// Mainly used for other unsupported files
/// ## Usage
/// ```swift
/// OtherFileView(otherFile)
/// ```
struct OtherFileView: NSViewRepresentable
{
  private var otherFile: CodeFileDocument

  /// Initialize the OtherFileView
  /// - Parameter otherFile: a file which contains URL to show preview
  init(
    _ otherFile: CodeFileDocument
  )
  {
    self.otherFile = otherFile
  }

  func makeNSView(context _: Context) -> QLPreviewView
  {
    let qlPreviewView = QLPreviewView()
    if let previewItemURL = otherFile.previewItemURL
    {
      qlPreviewView.previewItem = previewItemURL as QLPreviewItem
    }
    return qlPreviewView
  }

  /// Update preview file when file changed
  func updateNSView(_ nsView: QLPreviewView, context _: Context)
  {
    guard let currentPreviewItem = nsView.previewItem
    else
    {
      return
    }
    if let previewItemURL = otherFile.previewItemURL, previewItemURL != currentPreviewItem.previewItemURL
    {
      nsView.previewItem = previewItemURL as QLPreviewItem
    }
  }
}
