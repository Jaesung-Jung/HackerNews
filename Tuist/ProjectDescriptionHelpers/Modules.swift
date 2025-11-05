import ProjectDescription

// MARK: - Module

public enum Module: String, CaseIterable, Sendable {
  case app = "App"
  case domain = "Domain"
  case designSystem = "DesignSystem"
  case shared = "Shared"

  case composableArchitecture = "ComposableArchitecture"
  case dependencies = "Dependencies"

  public var name: String { rawValue }

  public var testName: String {
    "\(rawValue)Tests"
  }

  public var product: Product {
    guard isFramework else {
      return .app
    }
    return Environment.isDevelopment ? .framework : .staticFramework
  }

  var isProjectModule: Bool {
    switch self {
    case .app, .domain, .designSystem, .shared:
      return true
    default:
      return false
    }
  }

  var isFramework: Bool {
    switch self {
    case .app:
      return false
    default:
      return true
    }
  }
}

// MARK: - TargetDependency

extension TargetDependency {
  public static func dependency(_ module: Module) -> TargetDependency {
    if module.isProjectModule {
      return .project(target: module.name, path: .relativeToRoot("Projects/\(module.name)"))
    }
    return .external(name: module.name)
  }

  public static func target(_ module: Module) -> TargetDependency {
    .target(name: module.name)
  }
}

// MARK: - PackageSettings

extension PackageSettings {
  public static var defaultPackageSettings: PackageSettings {
    if Environment.isDevelopment {
      let packageNames = [
        "Dependencies",
        "CombineSchedulers",
        "ConcurrencyExtras",
        "IssueReporting",
        "IssueReportingPackageSupport",
        "XCTestDynamicOverlay"
      ]
      return PackageSettings(productTypes: packageNames.reduce(into: [:]) { $0[$1] = .framework })
    }
    return PackageSettings()
  }
}
