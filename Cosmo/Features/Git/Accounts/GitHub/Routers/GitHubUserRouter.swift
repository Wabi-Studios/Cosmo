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

enum GitHubUserRouter: GitRouter
{
  case readAuthenticatedUser(GitRouterConfiguration)
  case readUser(String, GitRouterConfiguration)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .readAuthenticatedUser(config): return config
      case let .readUser(_, config): return config
    }
  }

  var method: GitHTTPMethod
  {
    .GET
  }

  var encoding: GitHTTPEncoding
  {
    .url
  }

  var path: String
  {
    switch self
    {
      case .readAuthenticatedUser:
        return "user"
      case let .readUser(username, _):
        return "users/\(username)"
    }
  }

  var params: [String: Any]
  {
    [:]
  }
}
