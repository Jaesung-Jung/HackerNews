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

// MARK: - Story (Preview)

#if DEBUG

extension Story {
  public static let previewURLContent = Story(
    id: 45794032,
    date: Date(timeIntervalSince1970: 1762122762),
    author: "cjbarber",
    title: "Facts about throwing good parties",
    content: .url(URL(string: "https://www.atvbt.com/21-facts-about-throwing-good-parties/")!),
    score: 1931,
    commentIds: [
      45794946,
      45794756,
      45795893,
      45794696,
      45796043,
      45794494
    ]
  )

  public static let previewTextContent = Story(
    id: 45777351,
    date: Date(timeIntervalSince1970: 1761949541),
    author: "blindprogrammer",
    title: "Ask HN: Why I rarely see game dev startup here?",
    content: .text("Do investors despise game development companies, and do you have to go solo? If so, I would have expected to see at least one on Show HN. Or maybe I missed it—definitely not as popular as other apps.<p>Also, why haven’t LLM wrappers penetrated this sector? Is it because OpenAI and other “parasites” haven’t had the opportunity to access source code to build their wholesale theft, so they don’t have the code to instruct you to build games? Or maybe there are a lot, and I just missed them."),
    score: 519,
    commentIds: [
      45777694,
      45809787,
      45799417,
      45792018,
      45781126,
      45778415,
      45780509,
      45778892,
      45779998
    ]
  )
}

#endif
