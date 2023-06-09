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

class GitLabEventData: Codable
{
  var objectKind: String?
  var eventName: String?
  var before: String?
  var after: String?
  var ref: String?
  var checkoutSha: String?
  var message: String?
  var userID: Int?
  var userName: String?
  var userEmail: String?
  var userAvatar: URL?
  var projectID: Int?
  var project: GitLabProject?
  var commits: [GitLabCommit]?
  var totalCommitsCount: Int?

  enum CodingKeys: String, CodingKey
  {
    case objectKind = "object_kind"
    case eventName = "event_name"
    case before
    case after
    case ref
    case checkoutSha = "checkout_sha"
    case message
    case userID = "user_id"
    case userName = "user_name"
    case userEmail = "user_email"
    case userAvatar = "user_avater"
    case projectID = "project_id"
    case project
    case commits
    case totalCommitsCount = "total_commits_count"
  }
}
