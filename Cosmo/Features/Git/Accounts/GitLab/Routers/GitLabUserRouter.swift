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

enum GitLabUserRouter: GitRouter
{
  case readAuthenticatedUser(GitRouterConfiguration)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .readAuthenticatedUser(config): return config
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
    }
  }

  var params: [String: Any]
  {
    [:]
  }
}
