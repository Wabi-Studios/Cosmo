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

/// View that fixes [#1158](https://github.com/Wabi-Studios/Cosmo/issues/1158)
/// # Should **not** be used other than in a single file window.
struct WindowCodeFileView: View
{
  var codeFile: CodeFileDocument

  @State var hasAppeared = false
  @FocusState var focused: Bool

  var body: some View
  {
    Group
    {
      if !hasAppeared
      {
        Color.clear.onAppear
        {
          hasAppeared = true
          focused = true
        }
      }
      else
      {
        CodeFileView(codeFile: codeFile)
          .focused($focused)
      }
    }
  }
}
