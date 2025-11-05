import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.designSystem
let project = Project.project(
  name: .projectName("DesignSystem"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      module: module,
      bundleId: .bundleIdentifier("ui"),
      infoPlist: .default,
      buildableFolders: [.sources],
      scripts: [.swiftlint],
      dependencies: [
        .dependency(.shared)
      ],
      settings: .defaultTargetSettings(module)
    ),
    .testTarget(
      module: module,
      bundleId: .bundleIdentifier("ui", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
