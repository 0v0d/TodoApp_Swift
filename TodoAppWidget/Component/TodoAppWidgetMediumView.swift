//
//  TodoAppWidgetMediumView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

/// 中サイズウィジェット用のタスク表示ビュー
///
/// このビューは以下の情報を表示します：
/// - タイトルとステータスを上部に横並びで表示
/// - 期限を下部に表示
///
/// - Parameter task: 表示するタスク情報
struct TodoAppWidgetMediumView: View {
    /// 表示するタスクデータ
    let task: Todo

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 16) {
                ///タイトルを表示する行
                InfoWidgetRow(title: "Title", content: task.title, iconName: "doc.text")
                
                // ステータスを表示する行
                StatusInfoWidgetRow(status: task.status,iconName: "checkmark.circle.fill")
            }
            .padding(.horizontal)

            Divider() //　区切り線

            // 期日を表示する行
            InfoWidgetRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None"),
                iconName: "calendar.badge.clock"
            )
            .padding(.horizontal)
        }
    }
}
