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

class GitLabProjectAccess: Codable
{
  var accessLevel: Int?
  var notificationLevel: Int?

  init(_ json: [String: AnyObject])
  {
    accessLevel = json["access_level"] as? Int
    notificationLevel = json["notification_level"] as? Int
  }
}
