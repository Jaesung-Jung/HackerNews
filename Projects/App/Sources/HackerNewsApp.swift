//
//  HackerNewsApp.swift
//
//  Copyright © 2025 JS. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct HackerNewsApp: App {
  var body: some Scene {
    WindowGroup {
      StoryList(store: Store(initialState: StoryListFeature.State()) {
        StoryListFeature()
      })
    }
  }
}
