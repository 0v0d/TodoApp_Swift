//
//  TodoAppWidgetSmallView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

/// 小サイズウィジェット用のTodo表示ビュー
///
/// - Todoのタイトル
/// - Todoのステータス（完了、進行中、未着手）をアイコンと色で表現
///
/// - Parameter todo: 表示するTodo情報 (`Todo` 型)
struct TodoAppWidgetSmallView: View {

    let todo: Todo

    var body: some View {
        VStack(alignment: .leading) {
            InfoWidgetRow(
                title: "Title",
                content: todo.title,
                iconName: "doc.text"
            )

            Divider()

            StatusInfoWidgetRow(
                status: todo.status,
                iconName: "checkmark.circle.fill"
            )
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
