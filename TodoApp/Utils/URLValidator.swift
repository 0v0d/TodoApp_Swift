//
//  URLValidator.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/14.
//
import SwiftUI

struct URLValidator {
    func isValid(_ urlString: String) -> Bool {
        guard !urlString.isEmpty,
              let url = URL(string: urlString),
              UIApplication.shared.canOpenURL(url) else {
            return false
        }
        return true
    }
}
