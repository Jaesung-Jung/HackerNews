//
//  StoryRepository.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import Foundation
import HackerNewsShared

public struct StoryRepository {
  let fetchData: (API) async throws -> Data

  init(fetchData: @escaping (API) async throws -> Data) {
    self.fetchData = fetchData
  }
}

// MARK: - StoryRepository (Initializer)

extension StoryRepository {
  public init() {
    let baseURL = URL(string: "https://hacker-news.firebaseio.com/v0")!
    let session = URLSession(configuration: .default)
    self.init { api in
      let request = URLRequest(url: api.makeURL(baseURL: baseURL))
      let (data, _) = try await session.data(for: request)
      return data
    }
  }

  #if DEBUG

  public static func stub() -> StoryRepository {
    let json: (String) throws -> Data? = {
      try Bundle.module.url(forResource: $0, withExtension: "json").flatMap { try Data(contentsOf: $0) }
    }
    var stories: [String: Any]?
    return StoryRepository { api in
      switch api {
      case .stories(let type):
        return try json(type.rawValue) ?? Data()
      case .item(let id):
        if stories == nil {
          stories = try json("stories").flatMap { try JSONSerialization.jsonObject(with: $0) as? [String: Any] }
        }
        guard let item = stories?["\(id)"] else {
          return Data()
        }
        return try JSONSerialization.data(withJSONObject: item)
      }
    }
  }

  #endif
}

// MARK: - StoryRepository (Public)

extension StoryRepository {
  public func fetchStoryIds(for type: StoryType) async throws -> [Story.ID] {
    let data = try await fetchData(.stories(type))
    return try JSONDecoder().decode([Story.ID].self, from: data)
  }

  public func fetchStories<S: Sequence>(for storyIds: S) async throws -> [Story] where S.Element == Story.ID {
    let ids = Array(storyIds)
    var stories: [Story?] = .init(repeating: nil, count: ids.count)
    try await withThrowingTaskGroup { group in
      for (offset, id) in ids.enumerated() {
        group.addTask {
          let story = try await fetchStory(for: id)
          return (offset, story)
        }
      }
      for try await (offset, story) in group {
        stories[offset] = story
      }
    }
    return stories.compactMap { $0 }
  }

  public func fetchStory(for id: Story.ID) async throws -> Story {
    let data = try await fetchData(.item(id.rawValue))
    let decoder = JSONDecoder().then {
      $0.dateDecodingStrategy = .secondsSince1970
    }
    return try decoder.decode(Story.self, from: data)
  }
}

// MARK: - StoryRepository.StoryType

extension StoryRepository {
  public enum StoryType: String {
    case top = "topstories"
    case new = "newstories"
    case best = "beststories"
    case ask = "askstories"
    case show = "showstories"
    case job = "jobstories"
  }
}

// MARK: - StoryRepository.API

extension StoryRepository {
  enum API {
    case stories(StoryType)
    case item(Int)

    @inlinable func makeURL(baseURL: URL) -> URL {
      switch self {
      case .stories(let type):
        return baseURL.appending(component: "\(type.rawValue).json")
      case .item(let id):
        return baseURL.appending(component: "item/\(id).json")
      }
    }
  }
}
