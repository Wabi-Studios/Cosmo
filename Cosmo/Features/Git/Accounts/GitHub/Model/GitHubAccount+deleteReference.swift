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
#if canImport(FoundationNetworking)
  import FoundationNetworking
#endif

extension GitHubAccount
{
  /**
   Deletes a reference.
      - Parameters:
          - session: GitURLSession, defaults to URLSession.shared()
          - owner: The user or organization that owns the repositories.
          - repo: The repository on which the reference needs to be deleted.
          - ref: The reference to delete.
          - completion: Callback for the outcome of the deletion.
   */
  @discardableResult
  func deleteReference(
    _ session: GitURLSession = URLSession.shared,
    owner: String,
    repository: String,
    ref: String,
    completion: @escaping (_ response: Error?) -> Void
  ) -> GitURLSessionDataTaskProtocol?
  {
    let router = GitHubRouter.deleteReference(configuration, owner, repository, ref)
    return router.load(session, completion: completion)
  }
}
