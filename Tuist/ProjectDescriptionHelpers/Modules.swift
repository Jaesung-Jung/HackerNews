import ProjectDescription

// MARK: - Module

public enum Module {
  public static var productTypes: [String: Product] {
    let product: Product = .staticFramework
    return Module.Name.allCases.filter(\.isFramework).reduce(into: [:]) {
      $0[.moduleName($1)] = product
    }
  }
}

// MARK: - Module

extension Module {
  public enum Name: String, CaseIterable, Sendable {
    case app = "App"
    case domain = "Domain"
    case designSystem = "DesignSystem"
    case shared = "Shared"

    case composableArchitecture = "ComposableArchitecture"
    case alamofire = "Alamofire"
    case swiftSoup = "SwiftSoup"

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
}

// MARK: - TargetDependency

extension TargetDependency {
  public static func external(_ moduleName: Module.Name) -> TargetDependency {
    .external(name: .moduleName(moduleName))
  }

  public static func project(_ moduleName: Module.Name) -> TargetDependency {
    .project(target: .moduleName(moduleName), path: .relativeToRoot("Projects/\(String.moduleName(moduleName))"))
  }

  public static func target(_ moduleName: Module.Name) -> TargetDependency {
    .target(name: .moduleName(moduleName))
  }
}

// MARK: - String (Module Name)

extension String {
  public static func moduleName(_ moduleName: Module.Name) -> String {
    moduleName.rawValue
  }

  public static func testName(_ moduleName: Module.Name) -> String {
    "\(moduleName.rawValue)Tests"
  }
}
