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

import Foundation

extension URL
{
  func isImage() -> Bool
  {
    let ext: String = pathExtension.lowercased()

    // A list of supported file types by QLPreviewItem
    // Some of the image file types (in UTType) are not supported by QLPreviewItem
    let quickLookImageFileTypes: [String] = [
      "png",
      "jpg",
      "jpeg",
      "bmp",
      "pdf",
      "heic",
      "webp",
      "tiff",
      "gif",
      "tga",
      "avif",
      "psd",
      "svg",
    ]

    if quickLookImageFileTypes.contains(ext)
    {
      return true
    }
    else
    {
      return false
    }
  }
}
