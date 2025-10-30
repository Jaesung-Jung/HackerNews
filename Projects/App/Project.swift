import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(
  name: .projectName("App"),
  options: .defaultOptions,
  settings: .defaultProjectSettings,
  targets: [
    .target(
      name: .app,
      product: .app,
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
      dependencies: []
    )
  ]
)
