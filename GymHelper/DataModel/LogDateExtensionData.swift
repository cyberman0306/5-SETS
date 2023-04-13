//
//  LogDateExtensionData.swift
//  GymHelper
//
//  Created by yook on 2023/03/31.
//

import Foundation

extension Date {
    func dateString(_ date:Date? = nil) -> String {
        var targetDate:Date = self
        if let date = date {
            targetDate = date
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        
        return dateFormatter.string(from: targetDate)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}

extension String {
    
    func remove(target string: String) -> String {
    
        return components(separatedBy: string).joined()
    }
}
