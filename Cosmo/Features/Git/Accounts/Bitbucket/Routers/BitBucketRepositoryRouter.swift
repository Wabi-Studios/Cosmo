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

enum BitBucketRepositoryRouter: GitRouter
{
  case readRepositories(GitRouterConfiguration, String?, [String: String])
  case readRepository(GitRouterConfiguration, String, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .readRepositories(config, _, _): return config
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
      case .readRepositories(_, let userName, var nextParameters):
        if userName != nil
        {
          return nextParameters as [String: Any]
        }
        else
        {
          nextParameters["role"] = "member"
          return nextParameters as [String: Any]
        }
      case .readRepository:
        return [:]
    }
  }

  var path: String
  {
    switch self
    {
      case let .readRepositories(_, userName, _):
        if let userName
        {
          return "repositories/\(userName)"
        }
        else
        {
          return "repositories"
        }
      case let .readRepository(_, owner, name):
        return "repositories/\(owner)/\(name)"
    }
  }
}
