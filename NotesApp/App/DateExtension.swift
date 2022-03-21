//
//  DateExtension.swift
//  NotesApp
//
//  Created by Nikita Kirshin on 21.03.2022.
//

import Foundation

extension Date {
    func format() -> String {
        let formatter = DateFormatter()
        if Calendar.current.isDateInToday(self) {
            formatter.dateFormat = "h:mma"
            
        } else {
            formatter.dateFormat = "dd/MM/yy"
        }
        return formatter.string(from: self)
    }
}
