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

import SwiftUI

struct ContributorsRoot: Codable
{
  var contributors: [Contributor]
}

struct Contributor: Codable, Identifiable
{
  var id: String { login }
  var login: String
  var name: String
  var avatarURLString: String
  var profile: String
  var contributions: [Contribution]

  var avatarURL: URL?
  {
    URL(string: avatarURLString)
  }

  var gitHubURL: URL?
  {
    URL(string: "https://github.com/\(login)")
  }

  var profileURL: URL?
  {
    URL(string: profile)
  }

  enum CodingKeys: String, CodingKey
  {
    case login, name, profile, contributions
    case avatarURLString = "avatar_url"
  }

  enum Contribution: String, Codable
  {
    case design, code, studio, multiverse, bug, maintenance, plugin

    var color: Color
    {
      switch self
      {
        case .design: return .blue
        case .code: return .indigo
        case .studio: return .pink
        case .multiverse: return .purple
        case .bug: return .red
        case .maintenance: return .brown
        case .plugin: return .gray
      }
    }
  }
}
