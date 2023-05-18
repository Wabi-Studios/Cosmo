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

extension StringProtocol where Index == String.Index
{
  func ranges(
    of substring: some StringProtocol,
    options: String.CompareOptions = [],
    locale: Locale? = nil
  ) -> [Range<Index>]
  {
    var ranges: [Range<Index>] = []
    while let result = range(
      of: substring,
      options: options,
      range: (ranges.last?.upperBound ?? startIndex) ..< endIndex,
      locale: locale
    )
    {
      ranges.append(result)
    }
    return ranges
  }
}
