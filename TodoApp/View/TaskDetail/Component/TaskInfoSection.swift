//
//  TaskInfoSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskInfoSection: View {
    /// タスクの情報
    let task: Todo

    var body: some View {
        Section {
            // タスクのタイトル情報を表示する行
            InfoRow(title: "Title", content: task.title)

            // タスクのステータス情報を表示するカスタムビュー
            StatusInfo(status: task.status)

            // タスクのコメント情報を表示する行
            InfoRow(title: "Comment", content: task.comment)

            // タスクにURLが設定されている場合のみ表示
            if !task.url.isEmpty {
                InfoRow(title: "URL", content: task.url)
            }

            // タスクの期限（DueDate）を表示
            // 日付が設定されていない場合は「None」と表示
            InfoRow(
                title: "DueDate",
                content: task.dueDate?.formattedDateTime() ?? String(localized: "None")
            )

            // タスクの作成日（CreatedDate）を表示
            InfoRow(
                title: "CreatedDate",
                content: task.timestamp.formattedDateTime()
            )
        }
    }
}
