//
//  Item.swift
//  GmoriApp
//
//  Created by 0v0 on 2024/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
