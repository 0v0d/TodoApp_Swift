//
//  Item.swift
//  GmoriApp
//
//  Created by 0v0 on 2024/10/24.
//

import Foundation
import SwiftData

@Model
final class Todo {
    var title: String
    var comment: String
    var timestamp: Date
    
    init(title: String, comment: String, timestamp: Date) {
        self.title = title
        self.comment = comment
        self.timestamp = timestamp
    }
}
