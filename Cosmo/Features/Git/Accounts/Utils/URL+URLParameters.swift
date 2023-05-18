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

extension URL
{
  var URLParameters: [String: String]
  {
    guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return [:] }
    var params = [String: String]()
    components.queryItems?.forEach
    { queryItem in
      params[queryItem.name] = queryItem.value
    }
    return params
  }

  func bitbucketURLParameters() -> [String: String]
  {
    let stringParams = absoluteString.components(separatedBy: "?").last
    let params = stringParams?.components(separatedBy: "&")
    var returnParams: [String: String] = [:]
    if let params
    {
      for param in params
      {
        let keyValue = param.components(separatedBy: "=")
        if let key = keyValue.first, let value = keyValue.last
        {
          returnParams[key] = value
        }
      }
    }
    return returnParams
  }
}
