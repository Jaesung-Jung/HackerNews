import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.domain
let project = Project.project(
  name: .projectName("Domain"),
  options: .defaultOptions,
  settings: .defaultProjectSettings.withDevelopmentAssets(),
  targets: [
    .target(
      module: module,
      bundleId: .bundleIdentifier("domain"),
      infoPlist: .default,
      buildableFolders: [.sources, .resources],
      scripts: [.swiftlint],
      dependencies: [
        .dependency(.shared),
        .dependency(.dependencies)
      ],
      settings: .defaultTargetSettings(module)
    ),
    .testTarget(
      module: module,
      bundleId: .bundleIdentifier("domain", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
