//
//  NewGHParser.swift
//  ContribTracker
//
//  Created by Wayne Dahlberg on 3/10/24.
//

import Foundation
import SwiftSoup

enum NewGHParser {
  static func getDevelopmentDays(for username: String, completion: @escaping ([DevelopmentDay]) -> Void) {
    let url = URL(string: "https://github.com/\(username)")!
    
    // Create a data task to retrieve the content of the URL asynchronously
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      // Check for errors and valid data
      guard let data = data, error == nil else {
        print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
        completion([])
        return
      }
      
      do {
        // Convert the data to a String (HTML content)
        let html = String(decoding: data, as: UTF8.self)
        
        // Parse the HTML content
        let doc = try SwiftSoup.parse(html)
        let dayElements = try doc.getElementsByClass("ContributionCalendar-day")
        
        let developmentDays = dayElements.compactMap { element -> DevelopmentDay? in
          print(element)
          guard
            let dateString = try? element.attr("data-date"),
            let date = DateService.shared.dateFormatter.date(from: dateString),
            let dataCountString = try? element.attr("data-level"),
            let dataCount = Int(dataCountString)
          else { return nil }
          
          return DevelopmentDay(date: date, dataCount: dataCount)
        }
        print(developmentDays)
        
        let thisSaturday = Calendar.current.nextDate(
          after: Date(),
          matching: DateComponents(weekday: 7),
          matchingPolicy: .nextTime
        )!
        
        let _17WeeksAgo = Calendar.current.date(
          byAdding: .weekOfMonth,
          value: -17,
          to: thisSaturday
        )!
        
        let last17Weeks = developmentDays.filter {
          $0.date > _17WeeksAgo
        }
        
        // Invoke the completion handler on the main thread
        DispatchQueue.main.async {
          completion(last17Weeks)
        }
        
      } catch {
        print("Error parsing HTML: \(error)")
        DispatchQueue.main.async {
          completion([])
        }
      }
    }
    
    // Start the task
    task.resume()
  }
}
