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

enum BitBucketOAuthRouter: GitRouter
{
  case authorize(BitBucketOAuthConfiguration)
  case accessToken(BitBucketOAuthConfiguration, String)

  var configuration: GitRouterConfiguration?
  {
    switch self
    {
      case let .authorize(config): return config
      case let .accessToken(config, _): return config
    }
  }

  var method: GitHTTPMethod
  {
    switch self
    {
      case .authorize:
        return .GET
      case .accessToken:
        return .POST
    }
  }

  var encoding: GitHTTPEncoding
  {
    switch self
    {
      case .authorize:
        return .url
      case .accessToken:
        return .form
    }
  }

  var path: String
  {
    switch self
    {
      case .authorize:
        return "site/oauth2/authorize"
      case .accessToken:
        return "site/oauth2/access_token"
    }
  }

  var params: [String: Any]
  {
    switch self
    {
      case let .authorize(config):
        return ["client_id": config.token, "response_type": "code"]
      case let .accessToken(_, code):
        return ["code": code, "grant_type": "authorization_code"]
    }
  }

  var URLRequest: Foundation.URLRequest?
  {
    switch self
    {
      case let .authorize(config):
        let url = URL(string: path, relativeTo: URL(string: config.webEndpoint!)!)
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        return request(components!, parameters: params)
      case let .accessToken(config, _):
        let url = URL(string: path, relativeTo: URL(string: config.webEndpoint!)!)
        let components = URLComponents(url: url!, resolvingAgainstBaseURL: true)
        return request(components!, parameters: params)
    }
  }
}
