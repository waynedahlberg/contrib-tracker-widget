//
//  DateService.swift
//  ContribTracker
//
//  Created by Wayne Dahlberg on 3/10/24.
//

import Foundation

class DateService {
  private init() { }
  
  static let shared = DateService()
  
  var dateFormatter: DateFormatter = {
    let f = DateFormatter()
    f.dateFormat = "yyyy-MM-dd"
    return f
  }()
}
