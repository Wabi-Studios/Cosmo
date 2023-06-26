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

enum BitBucketTokenRouter: GitRouter
{
  case refreshToken(BitBucketOAuthConfiguration, String)
  case emptyToken(BitBucketOAuthConfiguration, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .refreshToken(config, _): return config
      default: return nil
    }
  }

  var method: GitHTTPMethod
  {
    .POST
  }

  var encoding: GitHTTPEncoding
  {
    .form
  }

  var params: [String: Any]
  {
    switch self
    {
      case let .refreshToken(_, token):
        return ["refresh_token": token, "grant_type": "refresh_token"]
      default: return ["": ""]
    }
  }

  var path: String
  {
    switch self
    {
      case .refreshToken:
        return "site/oauth2/access_token"
      default: return ""
    }
  }

  var URLRequest: Foundation.URLRequest?
  {
    switch self
    {
      case let .refreshToken(config, _):
        let url = URL(string: path, relativeTo: URL(string: config.webEndpoint!)!)
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        return request(components!, parameters: params)
      default: return nil
    }
  }
}
