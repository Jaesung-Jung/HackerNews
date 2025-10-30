//
//  Logger.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import OSLog

public struct Logger: Sendable {
  @inlinable public func log(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    printLog(file: file, function: function, line: line) {
      let log = "\(message())"
      $0.log("\(log)")
    }
  }

  @inlinable public func debug(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    printLog(file: file, function: function, line: line) {
      let log = "\(message())"
      $0.debug("\(log)")
    }
  }

  @inlinable public func info(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    printLog(file: file, function: function, line: line) {
      let log = "\(message())"
      $0.info("\(log)")
    }
  }

  @inlinable public func fault(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    printLog(file: file, function: function, line: line) {
      let log = "\(message())"
      $0.fault("\(log)")
    }
  }

  @inlinable public func error(_ message: @autoclosure () -> Any, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    printLog(file: file, function: function, line: line) {
      let log = "\(message())"
      $0.error("\(log)")
    }
  }

  @usableFromInline
  func printLog(file: String, function: String, line: Int, message: (borrowing os.Logger) -> Void) {
    #if DEBUG
    let logger = os.Logger(subsystem: className(file: file), category: "\(function):\(line)")
    message(logger)
    #endif
  }

  private func className(file: String) -> String {
    guard let endIndex = file.reversed().firstIndex(of: ".")?.base else {
      return file
    }
    let startIndex = file.reversed().firstIndex(of: "/")?.base ?? file.startIndex
    return String(file[startIndex..<file.index(before: endIndex)])
  }
}
