//
//  StatusInfo.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// タスクのステータスを表示するビュー
///
/// - Parameter status: タスクのステータス（`TaskStatus` 型）
///
/// - Note:
///  - このビューは、`TaskStatus` に基づいてタスクのステータスをテキストとして表示します
struct StatusInfo: View {

    let status: TaskStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // タイトルを表示
            Text(LocalizedStringKey("Status"))
                .font(.caption)
                .foregroundColor(.secondary)

            // ステータスを表示
            TaskStatusText(status: status, fontSize: .body)
        }
    }
}
