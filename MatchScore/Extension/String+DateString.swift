//
//  String+DateString.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

extension String {
    func dateFromString() -> Date? {
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        return dateFormatter.date(from: self)
    }
    
    func dateStringToMatchTimeFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormatter.date(from: self) else {
            return "Invalid Date"
        }
        
        let now = Date()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(date) {
            dateFormatter.dateFormat = "'Hoje' HH:mm"
        } else if calendar.dateComponents([.day], from: now, to: date).day! <= 7 {
            dateFormatter.dateFormat = "E HH:mm"
        } else {
            dateFormatter.dateFormat = "dd.MM HH:mm"
        }
        
        return dateFormatter.string(from: date)
    }
    
    var capitalizedSentence: String {
        self.prefix(1).capitalized + self.dropFirst().lowercased()
    }
}
