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

import XCTest
@testable import Cosmo

final class AcknowledgementsTests: XCTestCase
{
  var model: AcknowledgementsViewModel!

  override func setUpWithError() throws
  {
    model = .init()
  }

  override func tearDownWithError() throws
  {
    model = nil
  }

  func testAcknowledgementsNotEmpty() throws
  {
    XCTAssertFalse(model.acknowledgements.isEmpty)
  }
}
