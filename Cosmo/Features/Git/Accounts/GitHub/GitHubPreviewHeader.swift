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

// TODO: DOCS (Nanashi Li)

/// Some APIs provide additional data for new (preview) APIs if a custom header is added to the request.
///
/// - Note: Preview APIs are subject to change.
enum GitHubPreviewHeader
{
  /// The `Reactions` preview header provides reactions in `Comment`s.
  case reactions

  var header: GitHTTPHeader
  {
    switch self
    {
      case .reactions:
        return GitHTTPHeader(headerField: "Accept", value: "application/vnd.github.squirrel-girl-preview")
    }
  }
}
