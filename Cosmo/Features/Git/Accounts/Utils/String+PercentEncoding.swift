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

import Foundation

extension String
{
  /// Percent-encodes a string to be URL-safe
  ///
  /// See https://useyourloaf.com/blog/how-to-percent-encode-a-url-string/ for more info
  /// - returns: An optional string, with percent encoding to match RFC3986
  func stringByAddingPercentEncodingForRFC3986() -> String?
  {
    let unreserved = "-._~/?"
    var allowed = CharacterSet.alphanumerics
    allowed.insert(charactersIn: unreserved)
    return addingPercentEncoding(withAllowedCharacters: allowed)
  }
}
