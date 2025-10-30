//
//  Swift+Extension.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

// MARK: - Sequence

extension Sequence {
  /// Returns a sorted array of elements using a key path to compare values.
  ///
  /// - Parameter keyPath: The key path to the property used for sorting.
  /// - Returns: A sorted array of the sequence's elements.
  ///
  /// ```swfit
  /// struct Person {
  ///   let name: String
  ///   let age: Int
  /// }
  ///
  /// let people = [
  ///   Person(name: "Alice", age: 30),
  ///   Person(name: "Charlie", age: 25),
  ///   Person(name: "Bob", age: 35)
  /// ]
  ///
  /// let sortedByName = people.sorted(by: \.name)
  /// let sortedByAge = people.sorted(by: \.age)
  /// ```
  @inlinable public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
    sorted(by: keyPath, using: <)
  }

  /// Returns a sorted array of elements using a key path and a custom comparator.
  ///
  /// - Parameters:
  ///   - keyPath: The key path to the property used for sorting.
  ///   - areInIncreasingOrder: A function that compares two property values and returns `true` if they are in the desired order.
  /// - Returns: A sorted array of the sequence's elements.
  ///
  /// ```swfit
  /// struct Person {
  ///   let name: String
  ///   let age: Int
  /// }
  ///
  /// let people = [
  ///   Person(name: "Alice", age: 30),
  ///   Person(name: "Charlie", age: 25),
  ///   Person(name: "Bob", age: 35)
  /// ]
  ///
  /// let sortedByName = people.sorted(by: \.name, using: <)
  /// let sortedByAge = people.sorted(by: \.age, using: <)
  /// ```
  @inlinable public func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, using areInIncreasingOrder: (T, T) -> Bool) -> [Element] {
    sorted { areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath]) }
  }
}

// MARK: - Collection

extension Collection {
  /// Safely returns the element at the specified position, or `nil` if the index is out of bounds.
  ///
  /// - Parameter position: The index of the element.
  /// - Returns: The element at the specified index if it exists, otherwise `nil`.
  ///
  /// ```swift
  /// let items = [1, 2, 3, 4, 5]
  /// print(items[safe: 0]) // Optional(1)
  /// print(items[safe: 5]) // Optional(nil)
  /// ```
  @inlinable public subscript(safe position: Index) -> Element? {
    indices.contains(position) ? self[position] : nil
  }
}
