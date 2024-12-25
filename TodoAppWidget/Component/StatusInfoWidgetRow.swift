//
//  StatusInfoWidgetRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

/// タスクのステータスを表示する行コンポーネント
///
/// - Parameters:
///   - status: 表示するタスクのステータス (`TaskStatus`型)
///   - iconName: 使用するSF Symbolsのアイコン名 (`String`型)
///
/// - Note:
///  - ステータスに応じた色のアイコン
///  - "Status"というラベル
///  - ステータスのテキスト表示（完了、進行中、未着手）
///
/// - ステータスの表示色：
///  - 完了: 緑色
///  - 進行中: 青色
///  - 未着手: グレー
struct StatusInfoWidgetRow: View {

    let status: TaskStatus

    let iconName: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(status.color)
                .shadow(color: status.color.opacity(0.4), radius: 4, x: 0, y: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey("Status"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                TaskStatusText(status: status, fontSize: .body)
            }
        }
        .padding(.vertical, 8)
    }
}
