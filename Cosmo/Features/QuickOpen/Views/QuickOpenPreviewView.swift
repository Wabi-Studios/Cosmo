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

struct QuickOpenPreviewView: View
{
  private let queue = DispatchQueue(label: "foundation.wabi.cosmo.quickOpen.preview")
  private let item: CEWorkspaceFile

  @ObservedObject
  var document: CodeFileDocument

  init(
    item: CEWorkspaceFile
  )
  {
    self.item = item
    let doc = try? CodeFileDocument(
      for: item.url,
      withContentsOf: item.url,
      ofType: "public.source-code"
    )
    _document = .init(wrappedValue: doc ?? .init())
  }

  var body: some View
  {
    if let url = document.fileURL
    {
      if url.isImage()
      {
        if let image = NSImage(contentsOf: url)
        {
          GeometryReader
          { proxy in
            if image.size.width > proxy.size.width || image.size.height > proxy.size.height
            {
              OtherFileView(document)
            }
            else
            {
              // FIXME: The following code causes a bug where the image size doesn't change when zooming.
              // The proper version found in WorkspaceCodeFile.swift line 59 to 60.
              // Cannot use that code as the image obscures the open quickly overlay.
              // There might be a solution for this in QuickOpenView.swift or OverlayView.swift

              OtherFileView(document)
                .frame(
                  width: image.size.width,
                  height: image.size.height
                )
                .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
            }
          }
        }
        else
        {
          OtherFileView(document)
        }
      }
      else
      {
        CodeFileView(codeFile: document, isEditable: false)
      }
    }
  }
}
