//
//  TaskRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

/// タスクを表示するための行ビュー
///
/// - Parameters:
///  - taskTitle: タスクのタイトル
///  - taskStatus: タスクの状態
///
/// - Note:アイコン、タイトル、状態が横並びで表示されます。
struct TaskRow: View {

    let taskTitle: String

    let taskStatus: TaskStatus

    var body: some View {
        HStack {
            /// タスクのアイコン
            ///
            /// `document.fill` システムイメージを使用しており、タスクを表すアイコンとして表示されます。
            Image(systemName: "document.fill")
                .fontWeight(.bold) // アイコンを太字に設定
                .foregroundColor(.secondary) // セカンダリーカラーを適用

            /// タスクのタイトル
            ///
            /// タスクのタイトルを表示します。テキストは1行に制限され、長すぎる場合は末尾を省略して表示します。
            Text(taskTitle)
                .font(.callout) // フォントをコールアウトサイズに設定
                .lineLimit(1) // テキストを1行に制限
                .truncationMode(.tail) // 長い場合は末尾を省略

            Spacer() // アイコンと状態表示の間にスペースを挿入

            /// タスクの状態を表示するビュー
            ///
            /// 状態はカスタムビュー `TaskStatusText` を利用して表示されます。フォントサイズは `body` に設定されています。
            TaskStatusText(status: taskStatus, fontSize: .body)
                .layoutPriority(1) // レイアウトの優先度を設定
        }
        .padding(.vertical, 1) // 行全体に上下の余白を設定
    }
}
