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

class GitLabPermissions: Codable
{
  var projectAccess: GitLabProjectAccess?
  var groupAccess: GitLabGroupAccess?

  init(_ json: [String: AnyObject])
  {
    projectAccess = GitLabProjectAccess(json["project_access"] as? [String: AnyObject] ?? [:])
    groupAccess = GitLabGroupAccess(json["group_access"] as? [String: AnyObject] ?? [:])
  }
}
