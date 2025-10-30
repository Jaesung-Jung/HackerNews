// swift-tools-version: 6.0
import PackageDescription

#if TUIST
import struct ProjectDescription.PackageSettings
import enum ProjectDescriptionHelpers.Module

let packageSettings = PackageSettings(
  productTypes: Module.productTypes
)
#endif

let package = Package(
    name: "HackerNews",
    dependencies: [
      .package(url: "https://github.com/scinfu/SwiftSoup", from: "2.11.1")
    ]
)
