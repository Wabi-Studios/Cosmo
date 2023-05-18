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

import SwiftUI

final class AcknowledgementsViewModel: ObservableObject
{
  @Published
  private(set) var acknowledgements: [AcknowledgementDependency]

  var indexedAcknowledgements: [(index: Int, acknowledgement: AcknowledgementDependency)]
  {
    Array(zip(acknowledgements.indices, acknowledgements))
  }

  init(_ dependencies: [AcknowledgementDependency] = [])
  {
    acknowledgements = dependencies

    if acknowledgements.isEmpty
    {
      fetchDependencies()
    }
  }

  func fetchDependencies()
  {
    acknowledgements.removeAll()
    do
    {
      if let bundlePath = Bundle.main.path(forResource: "Package", ofType: "resolved")
      {
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8)
        let parsedJSON = try JSONDecoder().decode(AcknowledgementObject.self, from: jsonData!)
        for dependency in parsedJSON.pins.sorted(by: { $0.identity < $1.identity })
          where dependency.identity.range(
            of: "[Cc]ode[Ee]dit",
            options: .regularExpression,
            range: nil,
            locale: nil
          ) == nil
        {
          self.acknowledgements.append(
            AcknowledgementDependency(
              name: dependency.name,
              repositoryLink: dependency.location,
              version: dependency.state.version ?? "-"
            )
          )
        }
      }
    }
    catch
    {
      print(error)
    }
  }
}
