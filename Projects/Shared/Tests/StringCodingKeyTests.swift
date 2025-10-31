//
//  StringCodingKeyTests.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import Testing
@testable import HackerNewsShared

struct StringCodingKeyTests {
  @Test func initWithString() throws {
    let stringKey = try #require(StringCodingKey(stringValue: "string-key"))
    #expect(stringKey.stringValue == "string-key")
    #expect(stringKey.intValue == nil)

    let numericKey = try #require(StringCodingKey(stringValue: "123"))
    #expect(numericKey.stringValue == "123")
    #expect(numericKey.intValue == 123)
  }

  @Test func initWithInt() throws {
    let key = try #require(StringCodingKey(intValue: 42))
    #expect(key.stringValue == "42")
    #expect(key.intValue == 42)
  }

  @Test func initWithStringProtocol() {
    let stringKey = StringCodingKey("string-key")
    #expect(stringKey.stringValue == "string-key")
    #expect(stringKey.intValue == nil)

    let numericKey = StringCodingKey("123")
    #expect(numericKey.stringValue == "123")
    #expect(numericKey.intValue == 123)
  }

  @Test func initWithStringLiteral() {
    let stringKey: StringCodingKey = "string-key"
    #expect(stringKey.stringValue == "string-key")
    #expect(stringKey.intValue == nil)

    let numericKey: StringCodingKey = "123"
    #expect(numericKey.stringValue == "123")
    #expect(numericKey.intValue == 123)
  }
}
