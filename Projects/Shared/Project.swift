import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.shared
let project = Project.project(
  name: .projectName("Shared"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      module: module,
      bundleId: .bundleIdentifier("shared"),
      infoPlist: .default,
      buildableFolders: [.sources],
      scripts: [.swiftlint],
      dependencies: [
      ],
      settings: .defaultTargetSettings(module)
    ),
    .testTarget(
      module: module,
      bundleId: .bundleIdentifier("shared", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
