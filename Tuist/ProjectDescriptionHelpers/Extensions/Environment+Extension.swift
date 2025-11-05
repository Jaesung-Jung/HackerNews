import ProjectDescription

extension Environment {
  public static var isDevelopment: Bool {
    if case .string(let env) = Environment.env {
      return env.localizedLowercase == "dev"
    }
    return false
  }
}
