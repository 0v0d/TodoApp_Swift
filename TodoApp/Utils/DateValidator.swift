//
//  DateValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import Foundation

struct DateValidator {
    func isTimeValid(_ date: Date?) -> Bool {
        guard let date = date else { return true }
        return date >= Date()
    }

    func isDueDateValid(_ date: Date?) -> Bool {
        guard let date = date else { return true }
        return date >= Calendar.current.startOfDay(for: Date())
    }
}
