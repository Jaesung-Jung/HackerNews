import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.Name.shared
let project = Project.project(
  name: .projectName("Shared"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      name: module,
      product: .framework,
      bundleId: .bundleIdentifier("shared"),
      infoPlist: .default,
      buildableFolders: [.sources],
      scripts: [.swiftlint],
      dependencies: [
      ],
      settings: .defaultTargetSettings(module)
    ),
    .target(
      name: module,
      product: .unitTests,
      bundleId: .bundleIdentifier("shared", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
