//
//  TaskDetailView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/27.
//
import SwiftUI

struct TaskDetailView: View {
    /// 選択されたタスク
    let selectedTask: Todo

    /// タスク編集画面表示用のフラグ
    @State private var showingEditTask = false

    var body: some View {
        Form {
            // タスク情報を表示するセクション
            TaskInfoSection(task: selectedTask)
        }
        .toolbar {
            // ツールバーに編集ボタンを配置
            ToolbarItem(placement: .primaryAction) {
                Button("Edit") {
                    // 「編集ボタンを押すと編集画面表示フラグをtrueに設定
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
