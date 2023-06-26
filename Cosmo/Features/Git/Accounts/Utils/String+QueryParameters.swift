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

extension String
{
  var bitbucketQueryParameters: [String: String]
  {
    let parametersArray = components(separatedBy: "&")
    var parameters = [String: String]()
    parametersArray.forEach
    { parameter in
      let keyValueArray = parameter.components(separatedBy: "=")
      let (key, value) = (keyValueArray.first, keyValueArray.last)
      if let key = key?.removingPercentEncoding, let value = value?.removingPercentEncoding
      {
        parameters[key] = value
      }
    }
    return parameters
  }
}
