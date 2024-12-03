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
              let scheme = url.scheme,
              // http, httpsのみ許可
              ["http", "https"].contains(scheme),
              url.host != nil else {
            return false
        }
        return true
    }
}
