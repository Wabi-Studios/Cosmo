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

struct WindowObserver<Content: View>: View
{
  var window: NSWindow

  @ViewBuilder
  var content: Content

  /// The fullscreen state of the NSWindow.
  /// This will be passed into all child views as an environment variable.
  @State
  private var isFullscreen = false

  @AppSettings(\.general.tabBarStyle) var tabBarStyle

  @State var modifierFlags: NSEvent.ModifierFlags = []

  var body: some View
  {
    content
      .environment(\.modifierKeys, modifierFlags.intersection(.deviceIndependentFlagsMask))
      .onReceive(NSEvent.publisher(scope: .local, matching: .flagsChanged))
      { output in
        modifierFlags = output.modifierFlags
      }
      .environment(\.window, window)
      .environment(\.isFullscreen, isFullscreen)
      .onReceive(NotificationCenter.default.publisher(for: NSWindow.didEnterFullScreenNotification))
      { _ in
        isFullscreen = true
      }
      .onReceive(NotificationCenter.default.publisher(for: NSWindow.willExitFullScreenNotification))
      { _ in
        isFullscreen = false
      }
      // When tab bar style is changed, update NSWindow configuration as follows.
      .onChange(of: tabBarStyle)
      { newStyle in
        DispatchQueue.main.async
        {
          if newStyle == .native
          {
            window.titlebarSeparatorStyle = .none
          }
          else
          {
            window.titlebarSeparatorStyle = .automatic
          }
        }
      }
  }
}
