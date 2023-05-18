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
import UniformTypeIdentifiers

struct WorkspaceCodeFileView: View
{
  @EnvironmentObject
  private var tabManager: TabManager

  @EnvironmentObject
  private var tabgroup: TabGroupData

  var file: CEWorkspaceFile

  @ViewBuilder
  var codeView: some View
  {
    if let document = file.fileDocument
    {
      Group
      {
        switch document.typeOfFile
        {
          case .some(.text), .some(.data):
            CodeFileView(codeFile: document)
          default:
            otherFileView(document, for: file)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    else
    {
      Spacer()
      VStack(spacing: 10)
      {
        ProgressView()
        Text("Opening \(file.name)...")
      }
      Spacer()
    }
  }

  @ViewBuilder
  private func otherFileView(
    _ otherFile: CodeFileDocument,
    for _: CEWorkspaceFile
  ) -> some View
  {
    VStack(spacing: 0)
    {
      if let url = otherFile.previewItemURL,
         let image = NSImage(contentsOf: url),
         otherFile.typeOfFile == .image
      {
        GeometryReader
        { proxy in
          if image.size.width > proxy.size.width || image.size.height > proxy.size.height
          {
            OtherFileView(otherFile)
          }
          else
          {
            OtherFileView(otherFile)
              .frame(
                width: proxy.size.width * (proxy.size.width / image.size.width),
                height: proxy.size.height
              )
              .position(x: proxy.frame(in: .local).midX, y: proxy.frame(in: .local).midY)
          }
        }
      }
      else
      {
        OtherFileView(otherFile)
      }
    }
  }

  var body: some View
  {
    codeView
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .onHover
      { hover in
        DispatchQueue.main.async
        {
          if hover
          {
            NSCursor.iBeam.push()
          }
          else
          {
            NSCursor.pop()
          }
        }
      }
  }
}
