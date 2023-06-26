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

// TODO: DOCS (Nanashi Li)
extension BitBucketAccount
{
  func refreshToken(
    _ session: GitURLSession,
    oauthConfig: BitBucketOAuthConfiguration,
    refreshToken: String,
    completion: @escaping (_ response: Result<BitBucketTokenConfiguration, Error>) -> Void
  ) -> GitURLSessionDataTaskProtocol?
  {
    let request = BitBucketTokenRouter.refreshToken(oauthConfig, refreshToken).URLRequest

    var task: GitURLSessionDataTaskProtocol?

    if let request
    {
      task = session.dataTask(with: request)
      { data, response, _ in
        guard let response = response as? HTTPURLResponse else { return }

        guard let data else { return }
        do
        {
          let responseJSON = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
          if let responseJSON = responseJSON as? [String: AnyObject]
          {
            if response.statusCode != 200
            {
              let errorDescription = responseJSON["error_description"] as? String ?? ""
              let error = NSError(
                domain: "foundation.wabi.models.accounts.bitbucket",
                code: response.statusCode,
                userInfo: [NSLocalizedDescriptionKey: errorDescription]
              )
              completion(Result.failure(error))
            }
            else
            {
              let tokenConfig = BitBucketTokenConfiguration(json: responseJSON)
              completion(Result.success(tokenConfig))
            }
          }
        }
      }
      task?.resume()
    }
    return task
  }
}
