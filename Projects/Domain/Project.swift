import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.Name.domain
let project = Project.project(
  name: .projectName("Domain"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      name: module,
      product: .framework,
      bundleId: .bundleIdentifier("domain"),
      infoPlist: .default,
      buildableFolders: [.sources, .resources],
      scripts: [.swiftlint],
      dependencies: [
        .external(.alamofire),
        .external(.swiftSoup),
        .project(.shared)
      ],
      settings: .defaultTargetSettings(module)
    ),
    .target(
      name: module,
      product: .unitTests,
      bundleId: .bundleIdentifier("domain", "tests"),
      buildableFolders: [.tests],
      dependencies: [.target(module)],
      settings: .defaultTestTargetSettings(module)
    )
  ],
  additionalFiles: []
)
