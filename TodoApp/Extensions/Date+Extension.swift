//
//  Date+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/5.
//
import Foundation

extension Date {
    /// 現在の日付と時刻を "年/月/日 時:分 AM/PM" の形式でフォーマットした文字列を返します
    ///
    /// - Returns: フォーマットされた日付と時刻
    /// - Note:
    ///  - 例: "2024/11/05 10:30 AM"
    func formattedDateTime() -> String {
        self.formatted(
            .dateTime
                .year().month().day()
                .hour().minute()
                .year(.defaultDigits)
                .month(.defaultDigits)
                .day(.defaultDigits)
                .hour(.defaultDigits(amPM: .abbreviated))
                .minute(.defaultDigits)
        )
    }
}
