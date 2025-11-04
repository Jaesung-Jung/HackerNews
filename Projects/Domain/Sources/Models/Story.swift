//
//  Story.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import Foundation
import HackerNewsShared

public struct Story: Identifiable {
  public let id: ID

  public let date: Date
  public let author: String

  public let title: String
  public let url: URL

  public let score: Int
  public let commentIds: [Int]
}

// MARK: - Story.ID

extension Story {
  public struct ID: RawRepresentable, Decodable, Hashable {
    public var rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
}

// MARK: - Story (Decodable)

extension Story: Decodable {
  public init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: StringCodingKey.self)
    self.id = try container.decode(ID.self, forKey: "id")

    self.date = try container.decode(Date.self, forKey: "time")
    self.author = try container.decode(String.self, forKey: "by")

    self.title = try container.decode(String.self, forKey: "title")
    self.url = try container.decode(URL.self, forKey: "url")

    self.score = try container.decode(Int.self, forKey: "score")
    self.commentIds = try container.decodeIfPresent([Int].self, forKey: "kids") ?? []
  }
}
