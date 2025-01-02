//
//  EditTodoView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/28.
//
import SwiftUI

/// 編集対象のTodoを編集するための画面
///
/// - Parameters:
///  - viewModel: Todoを管理するビューモデルをEnvironmentObjectとして利用（`TodoViewModel`型）
///  - todo: 編集対象のTodo（`Todo`型）
struct EditTodoView: View {

    @EnvironmentObject var viewModel: HomeViewModel

    @Bindable var todo: Todo

    @State private var formData: TodoFormData

    /// 初期化時に編集対象のTodoをフォームデータに変換
    init(todo: Todo) {
        self.todo = todo
        // Todoの内容を元に初期フォームデータを作成
        _formData = State(initialValue: TodoFormData(from: todo))
    }

    var body: some View {
        // Todoフォームビューを利用してTodo編集画面を構築
        TodoFormView(
            formData: $formData, // フォームデータをバインド
            topBarTitle: "EditTodo", // ナビゲーションバーに表示されるタイトル
            action: saveTodo // 保存時のアクション
        )
    }

    /// 編集されたTodoを保存する処理
    private func saveTodo() {
        Task {

            // フォームの内容をTodoに反映
            todo.update(
                title: formData.title, // Todoのタイトル
                comment: formData.comment, // Todoのコメント
                url: formData.url, // Todoに関連付けられたURL
                dueDate: formData.dueDate, // Todoの期限日
                status: TodoStatus(rawValue: formData.status) ?? .notStarted // Todoのステータス
            )

            // ビューモデルを通じてTodoを非同期で更新
            await viewModel.updateTodo(todo)
        }
    }
}

#Preview {
    // プレビューでEditTodoViewを表示
    EditTodoView(todo: TodoTestData.todo)
}
