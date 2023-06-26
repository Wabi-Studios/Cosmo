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

/// A struct for holding information about a file and any matches it may have for a search query.
class SearchResultModel: Hashable
{
  var file: CEWorkspaceFile
  var lineMatches: [SearchResultMatchModel]

  init(
    file: CEWorkspaceFile,
    lineMatches: [SearchResultMatchModel] = []
  )
  {
    self.file = file
    self.lineMatches = lineMatches
  }

  static func == (lhs: SearchResultModel, rhs: SearchResultModel) -> Bool
  {
    lhs.file == rhs.file
      && lhs.lineMatches == rhs.lineMatches
  }

  func hash(into hasher: inout Hasher)
  {
    hasher.combine(file)
    hasher.combine(lineMatches)
  }
}
