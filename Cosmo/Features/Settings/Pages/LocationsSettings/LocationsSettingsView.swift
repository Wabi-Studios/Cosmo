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

/// A view that implements the `Locations` preference section
struct LocationsSettingsView: View
{
  var body: some View
  {
    SettingsForm
    {
      Section
      {
        applicationSupportLocation
        settingsLocation
        themesLocation
        extensionsLocation
      }
    }
  }
}

private extension LocationsSettingsView
{
  @ViewBuilder
  private var applicationSupportLocation: some View
  {
    ExternalLink(destination: Settings.shared.baseURL)
    {
      Text("Application Support")
      Text(Settings.shared.baseURL.path)
        .font(.footnote)
        .foregroundColor(.secondary)
    }
  }

  private var settingsLocation: some View
  {
    ExternalLink(destination: ThemeModel.shared.settingsURL)
    {
      Text("Settings")
      Text(ThemeModel.shared.settingsURL.path)
        .font(.footnote)
        .foregroundColor(.secondary)
    }
  }

  private var themesLocation: some View
  {
    ExternalLink(destination: ThemeModel.shared.themesURL)
    {
      Text("Themes")
      Text(ThemeModel.shared.themesURL.path)
        .font(.footnote)
        .foregroundColor(.secondary)
    }
  }

  private var extensionsLocation: some View
  {
    ExternalLink(destination: ThemeModel.shared.extensionsURL)
    {
      Text("Extensions")
      Text(ThemeModel.shared.extensionsURL.path)
        .font(.footnote)
        .foregroundColor(.secondary)
    }
  }
}
