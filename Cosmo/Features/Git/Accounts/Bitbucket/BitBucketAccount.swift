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

// TODO: DOCS (Nanashi Li)

struct BitBucketAccount
{
  let configuration: BitBucketTokenConfiguration

  init(_ config: BitBucketTokenConfiguration = BitBucketTokenConfiguration())
  {
    configuration = config
  }
}

extension GitRouter
{
  var URLRequest: Foundation.URLRequest?
  {
    request()
  }
}
