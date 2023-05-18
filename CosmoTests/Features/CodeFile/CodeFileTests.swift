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
import SwiftUI
import XCTest
@testable import Cosmo

final class CodeFileUnitTests: XCTestCase
{
  func testViewContentLoading() throws
  {
    let directory = try FileManager.default.url(
      for: .developerApplicationDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: true
    )
    .appendingPathComponent("Cosmo", isDirectory: true)
    .appendingPathComponent("WorkspaceClientTests", isDirectory: true)
    try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true)

    let fileURL = directory.appendingPathComponent("fakeFile.swift")

    let fileContent = "func test(){}"

    try fileContent.data(using: .utf8)?.write(to: fileURL)
    let codeFile = try CodeFileDocument(
      for: fileURL,
      withContentsOf: fileURL,
      ofType: "public.source-code"
    )
    XCTAssertEqual(codeFile.content, fileContent)
  }
}
