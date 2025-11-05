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
          let hacker = StoryRepository.stub()
          let ids = try await hacker.fetchStoryIds(for: .top)
          let story1 = try await hacker.fetchStory(for: ids[0])
          print(story1)
          let story2 = try await hacker.fetchStory(for: ids[1])
          print(story2)
        } catch {
          logger.fault(error)
        }
      }
  }
}

#Preview {
  ContentView()
}
