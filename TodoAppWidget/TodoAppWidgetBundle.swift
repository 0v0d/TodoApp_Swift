//
//  TodoAppWidgetBundle.swift
//  TodoAppWidget
//
//  Created by 0v0 on 2024/11/25.
//

import WidgetKit
import SwiftUI

/// Todoアプリケーションのウィジェットバンドル
///
/// - TodoAppWidget: タスク表示用のメインウィジェット
@main
struct TodoAppWidgetBundle: WidgetBundle {

    var body: some Widget {
        TodoAppWidget()
    }
}
