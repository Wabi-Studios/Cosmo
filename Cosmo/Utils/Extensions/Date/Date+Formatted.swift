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

extension Date
{
  /// Returns a formatted & localized string of a relative duration compared to the current date & time
  /// when the date is in `today` or `yesterday`. Otherwise it returns a formatted date in `short`
  /// format. The time is omitted.
  /// - Parameter locale: The locale. Defaults to `Locale.current`
  /// - Returns: A localized formatted string
  func relativeStringToNow(locale: Locale = .current) -> String
  {
    if Calendar.current.isDateInToday(self) ||
      Calendar.current.isDateInYesterday(self)
    {
      var style = RelativeFormatStyle(
        presentation: .named,
        unitsStyle: .abbreviated,
        locale: .current,
        calendar: .current,
        capitalizationContext: .standalone
      )

      style.locale = locale

      return formatted(style)
    }
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    formatter.locale = locale

    return formatter.string(from: self)
  }
}
