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
import SwiftUI

// TODO: DOCS (Nanashi Li)
class BitBucketUser: Codable
{
  var id: String?
  var login: String?
  var name: String?

  enum CodingKeys: String, CodingKey
  {
    case id
    case login = "username"
    case name = "display_name"
  }
}

class BitBucketEmail: Codable
{
  var isPrimary: Bool
  var isConfirmed: Bool
  var type: String?
  var email: String?

  enum CodingKeys: String, CodingKey
  {
    case isPrimary = "is_primary"
    case isConfirmed = "is_confirmed"
    case type
    case email
  }
}

extension BitBucketAccount
{
  func me(
    _ session: GitURLSession = URLSession.shared,
    completion: @escaping (_ response: Result<BitBucketUser, Error>) -> Void
  ) -> GitURLSessionDataTaskProtocol?
  {
    let router = BitBucketUserRouter.readAuthenticatedUser(configuration)

    return router.load(
      session,
      dateDecodingStrategy: .formatted(GitTime.rfc3339DateFormatter),
      expectedResultType: BitBucketUser.self
    )
    { user, error in
      if let error
      {
        completion(.failure(error))
      }
      else
      {
        if let user
        {
          completion(.success(user))
        }
      }
    }
  }

  func emails(
    _ session: GitURLSession = URLSession.shared,
    completion: @escaping (_ response: Result<BitBucketEmail, Error>) -> Void
  ) -> GitURLSessionDataTaskProtocol?
  {
    let router = BitBucketUserRouter.readEmails(configuration)

    return router.load(
      session,
      dateDecodingStrategy: .formatted(GitTime.rfc3339DateFormatter),
      expectedResultType: BitBucketEmail.self
    )
    { email, error in
      if let error
      {
        completion(.failure(error))
      }
      else
      {
        if let email
        {
          completion(.success(email))
        }
      }
    }
  }
}
