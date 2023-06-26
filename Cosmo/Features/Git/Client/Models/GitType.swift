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

enum GitType: String, Codable
{
  case modified = "M"
  case unknown = "??"
  case fileTypeChange = "T"
  case added = "A"
  case deleted = "D"
  case renamed = "R"
  case copied = "C"
  case updatedUnmerged = "U"

  var description: String
  {
    switch self
    {
      case .modified: return "M"
      case .unknown: return "?"
      case .fileTypeChange: return "T"
      case .added: return "A"
      case .deleted: return "D"
      case .renamed: return "R"
      case .copied: return "C"
      case .updatedUnmerged: return "U"
    }
  }
}
