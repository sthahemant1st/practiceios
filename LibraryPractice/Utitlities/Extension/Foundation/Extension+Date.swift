//
//  Date.swift
//  Yatru
//
//  Created by Sagun Raj Lage on 10/1/19.
//  Copyright © 2019 Nutan Niraula. All rights reserved.
//

import Foundation

extension Date {
    
    static func getDate(from stringDate: String, having format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: stringDate)!
    }
    
    func formattedDate(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = .current
        return formatter.string(from: self)
    }
   
    static func getDateTimeString(from stringDate: String, with format: String, to outputFormat: String) -> String? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        formatter.dateFormat = format
        guard let date = formatter.date(from: stringDate) else { return nil }
        formatter.dateFormat = outputFormat
        return formatter.string(from: date)
    }
    
}
