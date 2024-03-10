//
//  ContributionsGraphView.swift
//  ContribTracker
//
//  Created by Wayne Dahlberg on 3/10/24.
//

import SwiftUI

struct ContributionsGraphView: View {
  @Environment(\.colorScheme) var scheme
  
  let days: [DevelopmentDay]
  let selectedDay: (DevelopmentDay) -> Void
  
  static let boxSize: CGFloat = 15
  static let spacing: CGFloat = 4
  
  private let rows = Array(repeating: GridItem(.fixed(boxSize), spacing: 6), count: 7)
  
  var body: some View {
    LazyHGrid(rows: rows, content: {
      ForEach(days, id: \.date) { day in
        GitHubActivityColor(for: day.dataCount)
          .frame(width: Self.boxSize, height: Self.boxSize)
          .cornerRadius(4)
          .addBorder(scheme == .light ? .black.opacity(0.03) : .white.opacity(0.03), cornerRadius: 4)
          .onTapGesture {
            selectedDay(day)
          }
      }
    })
  }
  
  func GitHubActivityColor(for count: Int) -> Color {
    if count > 15 {
      return Color.activity4
    } else if count > 10 {
      return Color.activity3
    } else if count > 5 {
      return Color.activity2
    } else if count > 0 {
      return Color.activity1
    } else {
      return Color.activity0
    }
  }
}

//#Preview {
//  ContributionsGraphView(days: <#T##[DevelopmentDay]#>, selectedDay: <#T##(DevelopmentDay) -> Void#>)
//}
