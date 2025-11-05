import ProjectDescription

// MARK: - Project

extension Project {
  public static func project(
    name: String,
    options: Project.Options,
    settings: Settings? = nil,
    targets: [Target],
    additionalFiles: [FileElement] = []
  ) -> Project {
    Project(
      name: name,
      organizationName: .organizationName,
      options: options,
      settings: settings,
      targets: targets,
      fileHeaderTemplate: """

      //  ___FILENAME___
      //
      //  Copyright © 2025 Jaesung Jung. All rights reserved.
      //
      //  Permission is hereby granted, free of charge, to any person obtaining a copy
      //  of this software and associated documentation files (the "Software"), to deal
      //  in the Software without restriction, including without limitation the rights
      //  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
      //  copies of the Software, and to permit persons to whom the Software is
      //  furnished to do so, subject to the following conditions:
      //
      //  The above copyright notice and this permission notice shall be included in
      //  all copies or substantial portions of the Software.
      //
      //  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
      //  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
      //  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
      //  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
      //  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
      //  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
      //  THE SOFTWARE.
      """,
      additionalFiles: additionalFiles
    )
  }
}

// MARK: - Target

extension Target {
  public static func target(
    module: Module,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    buildableFolders: [BuildableFolder],
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency],
    settings: Settings? = nil
  ) -> Target {
    .target(
      name: module.name,
      destinations: .defaultDestinations,
      product: module.product,
      bundleId: bundleId,
      deploymentTargets: .defaultDeploymentTargets,
      infoPlist: infoPlist,
      buildableFolders: buildableFolders,
      entitlements: entitlements,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings
    )
  }

  public static func testTarget(
    module: Module,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    buildableFolders: [BuildableFolder],
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency],
    settings: Settings? = nil
  ) -> Target {
    .target(
      name: module.testName,
      destinations: .defaultDestinations,
      product: .unitTests,
      bundleId: bundleId,
      deploymentTargets: .defaultDeploymentTargets,
      infoPlist: infoPlist,
      buildableFolders: buildableFolders,
      entitlements: entitlements,
      scripts: scripts,
      dependencies: dependencies,
      settings: settings
    )
  }
}

// MARK: - Options

extension Project.Options {
  public static let defaultOptions = Project.Options.options(
    automaticSchemesOptions: .enabled(targetSchemesGrouping: .singleScheme),
    defaultKnownRegions: .knownRegions,
    developmentRegion: .developmentRegion,
    disableBundleAccessors: true,
    disableSynthesizedResourceAccessors: true,
    textSettings: .textSettings(usesTabs: false, indentWidth: 2, tabWidth: 2)
  )
}

// MARK: - Settings

extension Settings {
  public static var defaultProjectSettings: Settings {
    .settings(
      base: [
        "MARKETING_VERSION": .marketingVersion,
        "CURRENT_PROJECT_VERSION": .projectVersion,
        "ENABLE_USER_SCRIPT_SANDBOXING": false,
        "LOCALIZATION_EXPORT_SUPPORTED": true,
        "LOCALIZATION_PREFERS_STRING_CATALOGS": true,
        "LOCALIZED_STRING_SWIFTUI_SUPPORT": true,
        "STRING_CATALOG_GENERATE_SYMBOLS": true,
        "SWIFT_EMIT_LOC_STRINGS": true,
        "ASSETCATALOG_COMPILER_GENERATE_SWIFT_ASSET_SYMBOL_EXTENSIONS": true,
        "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor"
      ],
      defaultSettings: .recommended
    )
  }

  public static func defaultTargetSettings(_ module: Module) -> Settings {
    .settings(
      base: [
        "PRODUCT_NAME": "\(String.workspaceName)\(module.name)"
      ],
      defaultSettings: .recommended
    )
  }

  public static func defaultTestTargetSettings(_ module: Module) -> Settings {
    .settings(
      base: [
        "PRODUCT_NAME": "\(String.workspaceName)\(module.testName)"
      ],
      defaultSettings: .recommended
    )
  }

  public func withDevelopmentAssets() -> Settings {
    var settings = self
    settings.base["DEVELOPMENT_ASSET_PATHS"] = "Resources/Development"
    return settings
  }
}
