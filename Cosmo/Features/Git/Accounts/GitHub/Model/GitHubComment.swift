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

struct GitHubComment: Codable
{
  let id: Int
  let url: URL
  let htmlURL: URL
  let body: String
  let user: GitHubUser
  let createdAt: Date
  let updatedAt: Date

  enum CodingKeys: String, CodingKey
  {
    case id, url, body, user
    case htmlURL = "html_url"
    case createdAt = "created_at"
    case updatedAt = "updated_at"
  }
}
