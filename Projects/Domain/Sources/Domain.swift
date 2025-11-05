//
//  Domain.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

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
