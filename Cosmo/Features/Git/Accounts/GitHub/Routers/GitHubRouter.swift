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

enum GitHubRouter: GitJSONPostRouter
{
  case deleteReference(GitRouterConfiguration, String, String, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .deleteReference(config, _, _, _): return config
    }
  }

  var method: GitHTTPMethod
  {
    switch self
    {
      case .deleteReference:
        return .DELETE
    }
  }

  var encoding: GitHTTPEncoding
  {
    switch self
    {
      case .deleteReference:
        return .url
    }
  }

  var params: [String: Any]
  {
    switch self
    {
      case .deleteReference:
        return [:]
    }
  }

  var path: String
  {
    switch self
    {
      case let .deleteReference(_, owner, repo, reference):
        return "repos/\(owner)/\(repo)/git/refs/\(reference)"
    }
  }
}
