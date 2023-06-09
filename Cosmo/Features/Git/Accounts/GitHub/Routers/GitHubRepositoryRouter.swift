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

enum GitHubRepositoryRouter: GitRouter
{
  case readRepositories(GitRouterConfiguration, String, String, String)
  case readAuthenticatedRepositories(GitRouterConfiguration, String, String)
  case readRepository(GitRouterConfiguration, String, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .readRepositories(config, _, _, _): return config
      case let .readAuthenticatedRepositories(config, _, _): return config
      case let .readRepository(config, _, _): return config
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

  var params: [String: Any]
  {
    switch self
    {
      case let .readRepositories(_, _, page, perPage):
        return ["per_page": perPage, "page": page]
      case let .readAuthenticatedRepositories(_, page, perPage):
        return ["per_page": perPage, "page": page]
      case .readRepository:
        return [:]
    }
  }

  var path: String
  {
    switch self
    {
      case let .readRepositories(_, owner, _, _):
        return "users/\(owner)/repos"
      case .readAuthenticatedRepositories:
        return "user/repos"
      case let .readRepository(_, owner, name):
        return "repos/\(owner)/\(name)"
    }
  }
}
