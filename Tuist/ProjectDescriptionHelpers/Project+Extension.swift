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
      //  ___COPYRIGHT___
      //
      """,
      additionalFiles: additionalFiles
    )
  }
}

// MARK: - Target

extension Target {
  public static func target(
    name: Module.Name,
    product: Product,
    bundleId: String,
    infoPlist: InfoPlist = .default,
    buildableFolders: [BuildableFolder],
    entitlements: Entitlements? = nil,
    scripts: [TargetScript] = [],
    dependencies: [TargetDependency],
    settings: Settings? = nil
  ) -> Target {
    .target(
      name: product == .unitTests ? .testName(name) : .moduleName(name),
      destinations: .defaultDestinations,
      product: product,
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
  public static let defaultProjectSettings = Settings.settings(
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
      "ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME": "AccentColor",
      "DEVELOPMENT_ASSET_PATHS": "Resources/Development"
    ],
    defaultSettings: .recommended
  )

  public static func defaultTargetSettings(_ name: Module.Name) -> Settings {
    .settings(
      base: [
        "PRODUCT_NAME": "\(String.workspaceName)\(String.moduleName(name))"
      ],
      defaultSettings: .recommended
    )
  }

  public static func defaultTestTargetSettings(_ name: Module.Name) -> Settings {
    .settings(
      base: [
        "PRODUCT_NAME": "\(String.workspaceName)\(String.testName(name))"
      ],
      defaultSettings: .recommended
    )
  }
}
