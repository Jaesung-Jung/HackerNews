//
//  Domain.swift
//
//  Copyright © 2025 Jaesung Jung. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Dependencies

@_exported import HackerNewsShared

// MARK: - Logger

extension Logger: @retroactive DependencyKey {
  public static var liveValue = Logger()
}

// MARK: - StoryRepository

extension StoryRepository: DependencyKey {
  public static var liveValue = StoryRepository()
  public static var previewValue = StoryRepository.stub()
}

// MARK: - Dependencies

extension DependencyValues {
  public var logger: Logger {
    get { self[Logger.self] }
    set { self[Logger.self] = newValue }
  }

  public var storyRepository: StoryRepository {
    get { self[StoryRepository.self] }
    set { self[StoryRepository.self] = newValue }
  }
}
