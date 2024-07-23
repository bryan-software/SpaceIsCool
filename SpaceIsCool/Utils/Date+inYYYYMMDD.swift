//
//  Date+inYYYYMMDD.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 21/07/2024.
//

import Foundation

extension Date {
    func inYYYYMMDD() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: Date())
    }
}
