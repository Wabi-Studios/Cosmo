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

extension Bundle
{
  static var copyrightString: String?
  {
    Bundle.main.object(forInfoDictionaryKey: "NSHumanReadableCopyright") as? String
  }

  /// Returns the main bundle's version string if available (e.g. 1.0.0)
  static var versionString: String?
  {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }

  /// Returns the main bundle's build string if available (e.g. 123)
  static var buildString: String?
  {
    Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
  }

  static var versionPostfix: String?
  {
    Bundle.main.object(forInfoDictionaryKey: "CE_VERSION_POSTFIX") as? String
  }
}
