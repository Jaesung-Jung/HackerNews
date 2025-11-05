//
//  Story.swift
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

public struct Story: Identifiable {
  public let id: ID

  public let date: Date
  public let author: String

  public let title: String
  public let content: Content

  public let score: Int
  public let commentIds: [Int]
}

// MARK: - Story (Hashable)

extension Story: Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}

// MARK: - Story.ID

extension Story {
  public struct ID: RawRepresentable, Decodable, Hashable, ExpressibleByIntegerLiteral {
    public var rawValue: Int

    public init(rawValue: Int) {
      self.rawValue = rawValue
    }

    public init(integerLiteral value: IntegerLiteralType) {
      self.rawValue = Int(value)
    }
  }
}

// MARK: - Story.Content

extension Story {
  public enum Content: Hashable {
    case url(URL)
    case text(String)
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
    if let url = try container.decodeIfPresent(URL.self, forKey: "url") {
      self.content = .url(url)
    } else {
      self.content = .text(try container.decode(String.self, forKey: "text"))
    }

    self.score = try container.decode(Int.self, forKey: "score")
    self.commentIds = try container.decodeIfPresent([Int].self, forKey: "kids") ?? []
  }
}
