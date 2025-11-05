import ProjectDescription
import ProjectDescriptionHelpers

let module = Module.app
let project = Project(
  name: .projectName("App"),
  options: .defaultOptions,
  settings: .defaultProjectSettings.withDevelopmentAssets(),
  targets: [
    .target(
      module: module,
      bundleId: .bundleIdentifier(),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIImageName": "LaunchImage"
          ],
          "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false
          ],
          "UISupportedInterfaceOrientations": [
            "UIInterfaceOrientationPortrait"
          ]
        ]
      ),
      buildableFolders: [.sources, .resources],
      scripts: [.swiftlint],
      dependencies: [
        .dependency(.domain),
        .dependency(.composableArchitecture)
      ]
    )
  ]
)
