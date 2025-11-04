//
//  ThenTests.swift
//
//  Copyright © 2025 Playground. All rights reserved.
//

import Testing
@testable import HackerNewsShared

@Suite struct ThenTests {
  @Test func testMutate() {
    struct Person: Then {
      var name: String
      var age: Int
    }

    let original = Person(name: "Alice", age: 30)
    let mutated = original.mutate {
      $0.age = 27
    }

    #expect(original.name == "Alice" && original.age == 30)
    #expect(mutated.name == "Alice" && mutated.age == 27)
  }

  @Test func testThen() {
    class Person: Then {
      var name: String
      var age: Int

      init(name: String, age: Int) {
        self.name = name
        self.age = age
      }
    }

    let original = Person(name: "Alice", age: 30)
    let mutated = original.then {
      $0.age = 27
    }
    #expect(original.name == "Alice" && original.age == 27)
    #expect(mutated.name == "Alice" && mutated.age == 27)
  }
}
