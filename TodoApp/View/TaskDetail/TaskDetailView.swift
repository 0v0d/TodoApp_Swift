//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

/// 選択されたタスクの詳細情報を表示するビュー
///
///
/// - Parameters:
///   - selectedTask: 選択されたタスク（`Todo` 型）
///   - showingEditTask: 編集画面表示フラグ（`Bool`）
///
/// - Note:
/// - 編集ボタンを押すと編集画面を表示します
struct TaskDetailView: View {

    let selectedTask: Todo

    @State private var showingEditTask = false

    var body: some View {
        Form {
            Section {
                // タスクのタイトル情報を表示する行
                InfoRow(title: "Title", content: selectedTask.title)

                // タスクのステータス情報を表示するカスタムビュー
                StatusInfo(status: selectedTask.status)

                // タスクのコメント情報を表示する行
                InfoRow(title: "Comment", content: selectedTask.comment)

                // タスクにURLが設定されている場合のみ表示
                if !selectedTask.url.isEmpty {
                    InfoRow(title: "URL", content: selectedTask.url)
                }

                // タスクの期限（DueDate）を表示
                // 日付が設定されていない場合は「None」と表示
                InfoRow(
                    title: "DueDate",
                    content: selectedTask.dueDate?.formattedDateTime() ?? String(localized: "None")
                )

                // タスクの作成日（CreatedDate）を表示
                InfoRow(
                    title: "CreatedDate",
                    content: selectedTask.timestamp.formattedDateTime()
                )
            }
        }
        .toolbar {
            // ツールバーに編集ボタンを配置
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    // 編集ボタンを押すと編集画面表示フラグをtrueに設定
                    showingEditTask = true
                }
                .foregroundColor(.blue) // ボタンのテキストカラーを青に設定
            }
        }
        // 編集画面をモーダルで表示
        .sheet(isPresented: $showingEditTask) {
            EditTaskView(task: selectedTask)
        }
    }
}

#Preview {
    // プレビュー用のダミーデータを使用してTaskDetailViewを表示
    TaskDetailView(selectedTask: TodoTestData.todo)
}
