//
//  HackerNewsClient.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import Foundation
import SwiftSoup
import HackerNewsShared

public struct HackerNewsClient {
  let request: (Path) async throws -> Data

  init(request: @escaping (Path) async throws -> Data) {
    self.request = request
  }

  public init() {
    let baseURL = URL(string: "https://news.ycombinator.com")!
    let session = URLSession(configuration: .default)
    self.init {
      let (data, _) = try await session.data(for: $0.makeRequest(url: baseURL))
      return data
    }
  }

  public static func stub() -> HackerNewsClient {
    let logger = Logger()
    return HackerNewsClient { path in
      let filename = switch path {
      case .news(let page):
        "news-\(page)"
      default:
        ""
      }

      do {
        let data = try Bundle.main
          .url(forResource: filename, withExtension: "html")
          .flatMap { try Data(contentsOf: $0) }
        return data ?? Data()
      } catch {
        logger.error(error)
        return Data()
      }
    }
  }
}

// MARK: - HackerNewsClient.Path

extension HackerNewsClient {
  enum Path {
    case news(page: Int)
    case past(date: Date)
    case ask(page: Int)
    case show(page: Int)
    case jobs(page: Int)

    func makeRequest(url: URL) -> URLRequest {
      return URLRequest(url: url)
    }
  }
}
