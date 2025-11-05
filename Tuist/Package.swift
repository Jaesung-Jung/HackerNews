// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import enum ProjectDescriptionHelpers.Module

let packageSettings = PackageSettings.defaultPackageSettings

#endif

let package = Package(
    name: "HackerNews",
    dependencies: [
      .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.23.1"),
      .package(url: "https://github.com/Alamofire/Alamofire", from: "5.10.2")
    ]
)
