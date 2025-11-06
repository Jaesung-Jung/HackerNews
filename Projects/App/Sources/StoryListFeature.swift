//
//  StoryListFeature.swift
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

import ComposableArchitecture
import HackerNewsDomain

@Reducer
struct StoryListFeature {
  @Dependency(\.storyRepository) var storyRepository

  @ObservableState
  struct State: Equatable {
    var storyType: StoryType = .top
    var storyIds: [Story.ID] = []
    var stories: IdentifiedArrayOf<Story> = []
  }

  enum Action {
    case fetchStories(StoryType)
    case fetchStoriesResponse([Story.ID], [Story])
    case fetchNextStories
    case selectType(StoryType)
  }

  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .fetchStories(let type):
        return .run { send in
          let storyIds = try await storyRepository.fetchStoryIds(for: type)
          let stories = try await storyRepository.fetchStories(for: storyIds[..<min(30, storyIds.count)])
          await send(.fetchStoriesResponse(storyIds, stories))
        }

      case .fetchStoriesResponse(let storyIds, let stories):
        state.storyIds = storyIds
        state.stories = IdentifiedArray(uniqueElements: stories)
        return .none

      case .fetchNextStories:
        return .none

      case .selectType(let type):
        state.storyType = type
        return .none
      }
    }
  }
}
