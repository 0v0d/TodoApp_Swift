//
//  TaskListView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

/// タスクリストを表示するビュー
struct TaskListView: View {
    /// 編集モードを管理するEnvironment変数
    @Environment(\.editMode) private var editMode

    /// タスクのリストを受け取るプロパティ
    let tasks: [Todo]

    /// タスク削除時に呼び出されるクロージャ
    let deleteTask: (IndexSet) -> Void

    /// タスク移動時に呼び出されるクロージャ
    let moveTask: (IndexSet, Int) -> Void

    /// 選択されたタスクを管理するバインディングプロパティ
    @Binding var selectedTask: Todo?

    var body: some View {
        // 選択可能なリストビュー
        List(selection: $selectedTask) {
            // タスクごとにリストアイテムを生成
            ForEach(tasks) { task in
                // タスクの詳細ビューへのリンク
                NavigationLink(value: task) {
                    // タスク情報を表示するカスタム行
                    TaskRow(
                        taskTitle: task.title, // タスクのタイトルを表示
                        taskStatus: task.status // タスクのステータスを表示
                    )
                }
            }
            // スワイプで削除機能を有効化
            .onDelete(perform: deleteTask)
            // 編集モードが有効な場合のみ並べ替えを許可
            .onMove(perform: editMode?.wrappedValue.isEditing == true ? moveTask : nil)
        }
        .overlay {
            // タスクが空の場合、空状態ビューを表示
            if tasks.isEmpty {
                EmptyStateView(
                    title: "NoTasks", // 空状態のタイトル
                    iconName: "note.text", // アイコンの名前
                    description: "AddNewTaskMessage" // 空状態の説明メッセージ
                )
            }
        }
    }
}

#Preview {
    // プレビュー用のモックデータを使用してビューを表示
    TaskListView(
        tasks: TodoTestData.todos, // テスト用タスクリスト
        deleteTask: { _ in }, // 削除クロージャ (プレビューでは何もしない)
        moveTask: { _, _ in }, // 並べ替えクロージャ (プレビューでは何もしない)
        selectedTask: .constant(nil) // 選択されたタスク (初期値はnil)
    )
}
