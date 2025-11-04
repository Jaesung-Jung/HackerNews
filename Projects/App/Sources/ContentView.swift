//
//  ContentView.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import SwiftUI
import HackerNewsDomain
import HackerNewsShared

struct ContentView: View {
  let logger = Logger()

  var body: some View {
    Text("Hello, World!")
      .padding()
      .task {
        do {
          let hacker = StoryRepository()
          let ids = try await hacker.storyIds(for: .new)
//          print(ids)
          let stories = try await hacker.fetchStories(for: ids[..<5])
//          let stories = try await hacker.topStories(page: 1)
          print(stories)
          print(stories.count)
        } catch {
          logger.fault(error)
        }
      }
  }
}

#Preview {
  ContentView()
}
