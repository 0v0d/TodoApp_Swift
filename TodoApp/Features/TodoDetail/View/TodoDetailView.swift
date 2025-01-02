//
//  TodoDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

/// 選択されたTodoの詳細情報を表示するビュー
///
/// - Parameters:
///   - selectedTodo: 選択されたTodo（`Todo` 型）
///   - showingEditTodo: 編集画面表示フラグ（`Bool`）
///
/// - Note:
/// - 編集ボタンを押すと編集画面を表示します
struct TodoDetailView: View {

    let selectedTodo: Todo

    @State private var showingEditTodo = false

    var body: some View {
        Form {
            Section {
                // Todoのタイトル情報を表示する行
                InfoRow(title: "Title", content: selectedTodo.title)

                // Todoのステータス情報を表示するカスタムビュー
                StatusInfo(status: selectedTodo.status)

                // Todoのコメント情報を表示する行
                InfoRow(title: "Comment", content: selectedTodo.comment)

                // TodoにURLが設定されている場合のみ表示
                if !selectedTodo.url.isEmpty {
                    InfoRow(title: "URL", content: selectedTodo.url)
                }

                // Todoの期限（DueDate）を表示
                // 日付が設定されていない場合は「None」と表示
                InfoRow(
                    title: "DueDate",
                    content: selectedTodo.dueDate?.formattedDateTime() ?? String(localized: "None")
                )

                // Todoの作成日（CreatedDate）を表示
                InfoRow(
                    title: "CreatedDate",
                    content: selectedTodo.timestamp.formattedDateTime()
                )
            }
        }
        .toolbar {
            // ツールバーに編集ボタンを配置
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    // 編集ボタンを押すと編集画面表示フラグをtrueに設定
                    showingEditTodo = true
                }
                .foregroundColor(.blue) // ボタンのテキストカラーを青に設定
            }
        }
        // 編集画面をモーダルで表示
        .sheet(isPresented: $showingEditTodo) {
            EditTodoView(todo: selectedTodo)
        }
    }
}

#Preview {
    // プレビュー用のダミーデータを使用してTodoDetailViewを表示
    TodoDetailView(selectedTodo: TodoTestData.todo)
}
