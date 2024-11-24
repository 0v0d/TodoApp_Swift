//
//  Date+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//
import Foundation

extension Date {
    func formattedDateTime() -> String {
        self.formatted(
            .dateTime
                .year().month().day()
                .hour().minute()
                .locale(Locale(identifier: "ja_JP"))
                .year(.defaultDigits)
                .month(.defaultDigits)
                .day(.defaultDigits)
                .hour(.defaultDigits(amPM: .omitted))
                .minute(.defaultDigits)
        )
    }
}
