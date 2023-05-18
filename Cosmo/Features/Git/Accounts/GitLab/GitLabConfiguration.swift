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

struct GitLabTokenConfiguration: GitRouterConfiguration
{
  let provider = SourceControlAccount.Provider.gitlab
  var apiEndpoint: String?
  var accessToken: String?
  let errorDomain: String? = "foundation.wabi.models.accounts.gitlab"

  init(_ token: String? = nil, url: String? = nil)
  {
    apiEndpoint = url ?? provider.apiURL?.absoluteString
    accessToken = token
  }
}

struct GitLabPrivateTokenConfiguration: GitRouterConfiguration
{
  let provider = SourceControlAccount.Provider.gitlab
  var apiEndpoint: String?
  var accessToken: String?
  let errorDomain: String? = "foundation.wabi.models.accounts.gitlab"

  init(_ token: String? = nil, url: String? = nil)
  {
    apiEndpoint = url ?? provider.apiURL?.absoluteString
    accessToken = token
  }

  var accessTokenFieldName: String
  {
    "private_token"
  }
}
