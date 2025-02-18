//
//  StatusInfo.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// Todoのステータスを表示するビュー
///
/// - Parameter status: Todoのステータス（`TodoStatus` 型）
///
/// - Note:
///  - このビューは、`TodoStatus` に基づいてTodoのステータスをテキストとして表示します
struct StatusInfo: View {

    let status: TodoStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // タイトルを表示
            Text(LocalizedStringKey("Status"))
                .font(.caption)
                .foregroundColor(.secondary)

            // ステータスを表示
            TodoStatusText(status: status, fontSize: .body)
        }
    }
}
