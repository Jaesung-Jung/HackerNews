//
//  StoryItem.swift
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

import SwiftUI
import Dependencies
import HackerNewsDomain

struct StoryItem: View {
  let story: Story
  let isReaded: Bool

  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      HStack(spacing: 4) {
        Image(systemName: "person.fill")
        Text(story.author)

        Spacer()

        Image(systemName: "clock.fill")
        Text(story.date.formatted(.relative(presentation: .named)))
      }
      .font(.footnote)
      .foregroundStyle(isReaded ? .tertiary : .secondary)

      Text(story.title)
        .fontWeight(.medium)
        .foregroundStyle(isReaded ? .tertiary : .primary)

      HStack(spacing: 4) {
        Image(systemName: "text.bubble.fill")
        Text(story.commentIds.count.formatted(.number))

        Spacer()

        Button {
        } label: {
          HStack(spacing: 4) {
            Image(systemName: "arrowtriangle.up.fill")
            Text(story.score.formatted(.number))
          }
        }
        .buttonStyle(.bordered)
      }
      .font(.footnote)
      .foregroundStyle(isReaded ? .tertiary : .secondary)
    }
  }
}

// MARK: - StoryItem Preview

#if DEBUG

#Preview {
  VStack(spacing: 40) {
    StoryItem(story: .previewURLContent, isReaded: false)
    StoryItem(story: .previewTextContent, isReaded: true)
  }
  .padding(.horizontal, 20)
}

#endif
