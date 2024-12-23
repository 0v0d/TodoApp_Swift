//
//  StatusInfo.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct StatusInfo: View {
    /// タスクのステータス（`TaskStatus` 型）
    /// `TaskStatus` に応じて表示されるテキストや色を設定します。
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
