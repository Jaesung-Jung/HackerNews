//
//  Then.swift
//
//  Copyright © 2025 Playground. All rights reserved.
//

/// A protocol that provides convenience methods for modifying or configuring instances of types.
public protocol Then {}

extension Then where Self: Any {
  /// Returns a copy of the current value type after applying the given mutation block.
  ///
  /// - Parameter block: A closure that receives an inout reference to a copy of the value, allowing it to be modified.
  /// - Returns: A new instance of `Self` with the applied modifications.
  /// - Throws: Any error thrown by the block.
  ///
  /// ```swift
  /// struct Person: Then {
  /// var name: String
  ///   var age: Int
  /// }
  ///
  /// let original = Person(name: "Alice", age: 30)
  /// let mutated = original.mutate {
  ///   $0.age = 27
  /// }
  ///
  /// print(original.age) // 30
  /// print(mutated.age)  // 27
  /// ```
  @inlinable public func mutate(_ block: (inout Self) throws -> Void) rethrows -> Self {
    var copy = self
    try block(&copy)
    return copy
  }
}

extension Then where Self: AnyObject {
  /// Applies a configuration block to the current reference type and returns the instance.
  ///
  /// - Parameter block: A closure that receives a reference to `self`, allowing it to be configured.
  /// - Returns: The same instance of `Self` after the block is applied.
  /// - Throws: Any error thrown by the block.
  ///
  /// ```swift
  /// class Person: Then {
  ///   var name: String
  ///   var age: Int
  ///
  ///   init(name: String, age: Int) {
  ///     self.name = name
  ///     self.age = age
  ///   }
  /// }
  ///
  /// let original = Person(name: "Alice", age: 30)
  /// let mutated = original.then {
  ///   $0.age = 27
  /// }
  ///
  /// print(original.age) // 27
  /// print(mutated.age)  // 27
  /// ```
  @inlinable public func then(_ block: (Self) throws -> Void) rethrows -> Self {
    try block(self)
    return self
  }
}

#if canImport(Foundation)

import Foundation

extension NSObject: Then {}
extension JSONDecoder: Then {}
extension JSONEncoder: Then {}

#endif
