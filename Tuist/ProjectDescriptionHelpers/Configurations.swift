import Foundation
import ProjectDescription

fileprivate enum ProjectConfiguration {
  static let workspaceName = "HackerNews"
  static let organizationName = "JS"
  static let bundleIdentifier = "com.\(organizationName.lowercased()).\(workspaceName.lowercased())"
  static let destinations: Destinations = [.iPhone, .iPad]
  static let deploymentTargets: DeploymentTargets = .iOS("18.0")

  static let marketingVersion = "1.0.0"
  static let projectVersion = "1"

  static let knownRegions = ["Base", "en", "ko"]
  static let developmentRegion = "en"
}

// MARK: - Name

extension String {
  public static var workspaceName: String {
    ProjectConfiguration.workspaceName
  }

  public static func projectName(_ suffix: String) -> String {
    "\(ProjectConfiguration.workspaceName)\(suffix)"
  }

  public static var organizationName: String? {
    ProjectConfiguration.organizationName
  }
}

// MARK: - Bundle Identifier

extension String {
  public static func bundleIdentifier(_ suffix: String...) -> String {
    guard !suffix.isEmpty else {
      return ProjectConfiguration.bundleIdentifier
    }
    return "\(ProjectConfiguration.bundleIdentifier).\(suffix.map(\.localizedLowercase).joined(separator: "."))"
  }
}

// MARK: - Destinations

extension Destinations {
  public static let defaultDestinations = ProjectConfiguration.destinations
}

// MARK: - Deployment Targets

extension DeploymentTargets {
  public static let defaultDeploymentTargets = ProjectConfiguration.deploymentTargets
}

// MARK: - Versions

extension SettingValue {
  public static let marketingVersion: SettingValue = .string(ProjectConfiguration.marketingVersion)
  public static let projectVersion: SettingValue = .string(ProjectConfiguration.projectVersion)
}

// MARK: - Region

extension Collection where Element == String {
  public static var knownRegions: [String] { ProjectConfiguration.knownRegions }
}

extension String {
  public static let developmentRegion = ProjectConfiguration.developmentRegion
}

// MARK: - BuildableFolders

extension BuildableFolder {
  public static let sources: BuildableFolder = "Sources"
  public static let resources: BuildableFolder = "Resources"
  public static let tests: BuildableFolder = "Tests"
}
