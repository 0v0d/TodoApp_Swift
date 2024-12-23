//
//  TaskRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskRow: View {
    /// タスクタイトル
    let taskTitle: String

    /// タスクの状態
    let taskStatus: TaskStatus

    var body: some View {
        HStack {
            /// タスクのアイコン
            Image(systemName: "document.fill")
                .fontWeight(.bold) // 太字
                .foregroundColor(.secondary)

            /// タスクのタイトル
            Text(taskTitle)
                .font(.callout)
                .lineLimit(1) // 1行で表示
                .truncationMode(.tail) // 末尾を省略

            Spacer()

            TaskStatusText(status: taskStatus, fontSize: .body)
                .layoutPriority(1) // 他のビューを押しのけないように設定
        }
        .padding(.vertical, 1) // 上下に余白を設定
    }
}
