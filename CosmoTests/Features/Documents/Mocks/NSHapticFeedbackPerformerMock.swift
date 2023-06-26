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

import Cocoa

final class NSHapticFeedbackPerformerMock: NSObject, NSHapticFeedbackPerformer
{
  var invokedPerform = false
  var invokedPerformCount = 0

  func perform(
    _: NSHapticFeedbackManager.FeedbackPattern,
    performanceTime _: NSHapticFeedbackManager.PerformanceTime
  )
  {
    invokedPerform = true
    invokedPerformCount += 1
  }
}
