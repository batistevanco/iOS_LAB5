//
//  DateUtil.swift
//  Uurrooster
//
//  Created by Dirk Hostens on 14/10/2022.
//

import Foundation

struct DateUtil {
    static func formatDateTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd' 'HH:mm:00"
        return formatter.string(from: date)
    }
    static func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    static func getDate(string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: string)
        return date ?? Date()
    }

}
