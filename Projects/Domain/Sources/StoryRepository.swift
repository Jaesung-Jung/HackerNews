//
//  StoryRepository.swift
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
      case .storyIds(let type):
        return try json(type.resourceName) ?? Data()
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
    let data = try await fetchData(.storyIds(type))
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
    do {
      return try decoder.decode(Story.self, from: data)
    } catch {
      print("throw id: \(id)")
      throw error
    }
  }
}

// MARK: - StoryRepository.API

extension StoryRepository {
  enum API {
    case storyIds(StoryType)
    case item(Int)

    @inlinable func makeURL(baseURL: URL) -> URL {
      switch self {
      case .storyIds(let type):
        return baseURL.appending(component: "\(type.resourceName).json")
      case .item(let id):
        return baseURL.appending(component: "item/\(id).json")
      }
    }
  }
}
