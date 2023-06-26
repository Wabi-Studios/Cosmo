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

struct ImageFileView: View
{
  private let image: NSImage?

  init(image: NSImage?)
  {
    self.image = image
  }

  var body: some View
  {
    GeometryReader
    { proxy in
      if let image
      {
        if image.size.width > proxy.size.width || image.size.height > proxy.size.height
        {
          Image(nsImage: image)
            .resizable()
            .scaledToFit()
        }
        else
        {
          Image(nsImage: image)
            .frame(width: proxy.size.width, height: proxy.size.height)
        }
      }
      else
      {
        EmptyView()
      }
    }
  }
}
