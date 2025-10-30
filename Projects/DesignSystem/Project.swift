import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.Name.designSystem
let project = Project.project(
  name: .projectName("DesignSystem"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      name: module,
      product: .framework,
      bundleId: .bundleIdentifier("ui"),
      infoPlist: .default,
      buildableFolders: [.sources],
      scripts: [.swiftlint],
      dependencies: [
        .project(.shared)
      ],
      settings: .defaultTargetSettings(module)
    ),
    .target(
      name: module,
      product: .unitTests,
      bundleId: .bundleIdentifier("ui", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
