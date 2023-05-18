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
import SwiftUI

struct SettingsTextEditor: View
{
  @State
  private var isFocus: Bool = false

  @Binding
  var text: String

  init(text: Binding<String>)
  {
    _text = text
  }

  var body: some View
  {
    Representable(text: $text, isFocused: $isFocus)
      .overlay(focusOverlay)
  }

  private var focusOverlay: some View
  {
    Rectangle().stroke(Color.accentColor.opacity(isFocus ? 0.4 : 0), lineWidth: 2)
  }
}

private extension SettingsTextEditor
{
  struct Representable: NSViewRepresentable
  {
    @Binding var text: String
    @Binding var isFocused: Bool

    func makeNSView(context: Context) -> NSScrollView
    {
      let scrollView = NSTextView.scrollableTextView()
      scrollView.verticalScroller?.alphaValue = 0
      let textView = scrollView.documentView as? NSTextView
      textView?.backgroundColor = .windowBackgroundColor
      textView?.isEditable = true
      textView?.delegate = context.coordinator
      textView?.string = text
      return scrollView
    }

    func updateNSView(_: NSScrollView, context _: Context)
    {}

    func makeCoordinator() -> Coordinator
    {
      Coordinator(parent: self)
    }

    class Coordinator: NSObject, NSTextViewDelegate
    {
      var parent: Representable

      init(parent: Representable)
      {
        self.parent = parent
      }

      func textDidBeginEditing(_: Notification)
      {
        parent.isFocused = true
      }

      func textDidEndEditing(_: Notification)
      {
        parent.isFocused = false
      }

      func textDidChange(_ notification: Notification)
      {
        guard let textView = notification.object as? NSTextView
        else
        {
          return
        }
        // Update text
        parent.text = textView.string
      }
    }
  }
}
