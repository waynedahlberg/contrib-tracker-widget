//
//  ContentView.swift
//  ContribTracker
//
//  Created by Wayne Dahlberg on 3/10/24.
//

import SwiftUI

struct ContentView: View {
  
  @StateObject var viewModel = ViewModel()
  
  var body: some View {
    ContributionsGraphView(
      days: viewModel.days,
      selectedDay: { viewModel.selectedDay = $0 }
    )
    
    if let selectedDay = viewModel.selectedDay {
      Text("You made \(selectedDay.dataCount) contribution(s) on \(DateService.shared.dateFormatter.string(from: selectedDay.date))")
    }
  }
}

extension ContentView {
  class ViewModel: ObservableObject {
    @Published var days = [DevelopmentDay]()
    @Published var selectedDay: DevelopmentDay?
    
    init() {
      getDevelopmentDays()
    }
    
    private func getDevelopmentDays() {
      NewGHParser.getDevelopmentDays(for: "waynedahlberg") { [weak self] days in
        self?.days = days
      }
    }
    
  }
}

#Preview {
  ContentView()
}
