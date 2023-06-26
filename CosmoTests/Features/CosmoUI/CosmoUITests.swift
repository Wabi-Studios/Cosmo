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
import SnapshotTesting
import SwiftUI
import XCTest
@testable import Cosmo

final class CosmoUIUnitTests: XCTestCase
{
  // MARK: Help Button

  func testHelpButtonLight() throws
  {
    let view = HelpButton(action: {})
    let hosting = NSHostingView(rootView: view)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 40, height: 40))
    hosting.appearance = .init(named: .aqua)
    assertSnapshot(matching: hosting, as: .image(size: .init(width: 40, height: 40)))
  }

  func testHelpButtonDark() throws
  {
    let view = HelpButton(action: {})
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .darkAqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 40, height: 40))
    assertSnapshot(matching: hosting, as: .image)
  }

  // MARK: Segmented Control

  func testSegmentedControlLight() throws
  {
    let view = SegmentedControl(.constant(0), options: ["Opt1", "Opt2"])
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .aqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 30))
    assertSnapshot(matching: hosting, as: .image)
  }

  func testSegmentedControlDark() throws
  {
    let view = SegmentedControl(.constant(0), options: ["Opt1", "Opt2"])
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .darkAqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 30))
    assertSnapshot(matching: hosting, as: .image)
  }

  func testSegmentedControlProminentLight() throws
  {
    let view = SegmentedControl(.constant(0), options: ["Opt1", "Opt2"], prominent: true)
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .aqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 30))
    assertSnapshot(matching: hosting, as: .image)
  }

  func testSegmentedControlProminentDark() throws
  {
    let view = SegmentedControl(.constant(0), options: ["Opt1", "Opt2"], prominent: true)
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .darkAqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 30))
    assertSnapshot(matching: hosting, as: .image)
  }

  // MARK: EffectView

  func testEffectViewLight() throws
  {
    let view = EffectView()
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .aqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 20, height: 20))
    assertSnapshot(matching: hosting, as: .image)
  }

  func testEffectViewDark() throws
  {
    let view = EffectView()
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .darkAqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 20, height: 20))
    assertSnapshot(matching: hosting, as: .image)
  }

  // MARK: ToolbarBranchPicker

  func testBranchPickerLight() throws
  {
    let view = ToolbarBranchPicker(
      shellClient: ShellClient(),
      workspaceFileManager: nil
    )
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .aqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 50))
    assertSnapshot(matching: hosting, as: .image)
  }

  func testBranchPickerDark() throws
  {
    let view = ToolbarBranchPicker(
      shellClient: ShellClient(),
      workspaceFileManager: nil
    )
    let hosting = NSHostingView(rootView: view)
    hosting.appearance = .init(named: .darkAqua)
    hosting.frame = CGRect(origin: .zero, size: .init(width: 100, height: 50))
    assertSnapshot(matching: hosting, as: .image)
  }
}
