//
//  StringCodingKey.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

public struct StringCodingKey: CodingKey {
  public let stringValue: String
  public let intValue: Int?

  public init?(stringValue: String) {
    self.stringValue = stringValue
    self.intValue = Int(stringValue)
  }

  public init?(intValue: Int) {
    self.intValue = intValue
    self.stringValue = "\(intValue)"
  }

  public init?<S: StringProtocol>(_ string: S) {
    self.init(stringValue: String(string))
  }
}

// MARK: - StringCodingKey (ExpressibleByStringLiteral)

extension StringCodingKey: ExpressibleByStringLiteral {
  public init(stringLiteral: StringLiteralType) {
    self.stringValue = stringLiteral
    self.intValue = Int(stringLiteral)
  }
}
