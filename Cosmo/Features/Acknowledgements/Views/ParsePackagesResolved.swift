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

struct AcknowledgementDependency: Decodable
{
  var name: String
  var repositoryLink: String
  var version: String
  var repositoryURL: URL
  {
    URL(string: repositoryLink)!
  }
}

// MARK: - Object

struct AcknowledgementObject: Codable
{
  let pins: [AcknowledgementPin]
}

// MARK: - Pin

struct AcknowledgementPin: Codable
{
  let identity: String
  let location: String
  let state: AcknowledgementPackageState

  var name: String
  {
    location.split(separator: "/").last?.replacingOccurrences(of: ".git", with: "") ?? identity
  }
}

// MARK: - State

struct AcknowledgementPackageState: Codable
{
  let revision: String
  let version: String?
}
