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

import XCTest
@testable import Cosmo

final class DocumentsUnitTests: XCTestCase
{
  /// Properties
  private var splitViewController: CosmoSplitViewController!
  private var hapticFeedbackPerformerMock: NSHapticFeedbackPerformerMock!

  // MARK: - Lifecycle

  override func setUp()
  {
    super.setUp()
    hapticFeedbackPerformerMock = .init()
    splitViewController = .init(workspace: WorkspaceDocument(), feedbackPerformer: hapticFeedbackPerformerMock)
  }

  override func tearDown()
  {
    hapticFeedbackPerformerMock = nil
    splitViewController = nil
    super.tearDown()
  }

  // MARK: - Tests

  func testSplitViewControllerSnappedWhenWidthInAppropriateRange()
  {
    // Given
    let position = (260 ... 280).randomElement() ?? .zero

    // When
    let result = splitViewController.splitView(
      splitViewController.splitView,
      constrainSplitPosition: .init(position),
      ofSubviewAt: .zero
    )

    // Then
    XCTAssertEqual(result, 272)
  }

  func testSplitViewControllerStopSnappedWhenWidthIsLowerAppropriateRange()
  {
    // Given
    // 242 is the minimum width of the sidebar
    let position = (242 ..< 260).randomElement() ?? .zero

    // When
    let result = splitViewController.splitView(
      splitViewController.splitView,
      constrainSplitPosition: .init(position),
      ofSubviewAt: .zero
    )

    // Then
    XCTAssertEqual(result, .init(position))
  }

  func testSplitViewControllerStopSnappedWhenWidthIsHigherAppropriateRange()
  {
    // Given
    let position = (281 ... 500).randomElement() ?? .zero

    // When
    let result = splitViewController.splitView(
      splitViewController.splitView,
      constrainSplitPosition: .init(position),
      ofSubviewAt: .zero
    )

    // Then
    XCTAssertEqual(result, .init(position))
  }

  func testSplitViewControllerProducedHapticFeedback()
  {
    // Given
    let position = (260 ... 280).randomElement() ?? .zero

    // When
    _ = splitViewController.splitView(
      splitViewController.splitView,
      constrainSplitPosition: .init(position),
      ofSubviewAt: .zero
    )

    // Then
    XCTAssertTrue(hapticFeedbackPerformerMock.invokedPerform)
    XCTAssertEqual(hapticFeedbackPerformerMock.invokedPerformCount, 1)
  }

  func testSplitViewControllerProducedHapticFeedbackOnceWhenPlentyChangesOccur()
  {
    // Given
    let firstPosition = (260 ... 280).randomElement() ?? .zero
    let secondPosition = 300

    // When
    [firstPosition, secondPosition].forEach
    { position in
      _ = splitViewController.splitView(
        splitViewController.splitView,
        constrainSplitPosition: .init(position),
        ofSubviewAt: .zero
      )
    }

    // Then
    XCTAssertTrue(hapticFeedbackPerformerMock.invokedPerform)
    XCTAssertEqual(hapticFeedbackPerformerMock.invokedPerformCount, 1)
  }
}
