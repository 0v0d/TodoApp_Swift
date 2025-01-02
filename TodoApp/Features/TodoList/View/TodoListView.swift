//
//  TodoListView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI
import SwiftData

/// Todoリストを表示するビュー
///
/// - Parameters:
///  - todos: 表示するTodoのリスト (`[Todo]` 型)
///  - deleteTodo: Todo削除時に呼び出されるクロージャ (`IndexSet` 型)
///  - moveTodo: Todo移動時に呼び出されるクロージャ (`IndexSet`, `Int` 型)
///  - selectedTodo: 選択されたTodoを管理するバインディングプロパティ (`Todo?` 型)
struct TodoListView: View {

    @Environment(\.editMode) private var editMode

    let todos: [Todo]

    let deleteTodo: (IndexSet) -> Void

    let moveTodo: (IndexSet, Int) -> Void

    @Binding var selectedTodo: Todo?

    var body: some View {
        // 選択可能なリストビュー
        List(selection: $selectedTodo) {
            // Todoごとにリストアイテムを生成
            ForEach(todos) { todo in
                // Todoの詳細ビューへのリンク
                NavigationLink(value: todo) {
                    // Todo情報を表示するカスタム行
                    TodoRow(
                        title: todo.title, // Todoのタイトルを表示
                        status: todo.status // Todoのステータスを表示
                    )
                }
            }
            // スワイプで削除機能を有効化
            .onDelete(perform: deleteTodo)
            // 編集モードが有効な場合のみ並べ替えを許可
            .onMove(perform: editMode?.wrappedValue.isEditing == true ? moveTodo : nil)
        }
        .overlay {
            // Todoが空の場合、空状態ビューを表示
            if todos.isEmpty {
                EmptyStateView(
                    title: "NoTodos", // 空状態のタイトル
                    iconName: "note.text", // アイコンの名前
                    description: "AddNewTodoMessage" // 空状態の説明メッセージ
                )
            }
        }
    }
}

#Preview {
    // プレビュー用のモックデータを使用してビューを表示
    TodoListView(
        todos: TodoTestData.todos, // テスト用Todoリスト
        deleteTodo: { _ in }, // 削除クロージャ (プレビューでは何もしない)
        moveTodo: { _, _ in }, // 並べ替えクロージャ (プレビューでは何もしない)
        selectedTodo: .constant(nil) // 選択されたTodo (初期値はnil)
    )
}
