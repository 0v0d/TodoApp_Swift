//
//  AddTodoView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

/// Todoの新規追加を行うための画面
///
/// - Parameter viewModel: Todoを管理するビューモデルをEnvironmentObjectとして利用（`TodoViewModel`型）
struct AddTodoView: View {
    @EnvironmentObject var viewModel: HomeViewModel

    @State private var formData = TodoFormData()

    var body: some View {
        // Todoフォームビューを利用してTodo追加画面を構築
        TodoFormView(
            formData: $formData, // フォームの入力データをバインド
            topBarTitle: "NewTodo", // 上部のナビゲーションバーに表示されるタイトル
            action: addTodo // 保存時のアクションを設定
        )
    }

    /// フォームの内容を元にTodoを追加する処理
    private func addTodo() {
        Task {
            // フォームデータからTodoを生成
            let todo = Todo(
                title: formData.title, // Todoのタイトル
                comment: formData.comment, // Todoのコメント
                url: formData.url, // Todoに関連付けられたURL
                timestamp: Date(), // 作成日時を現在時刻に設定
                dueDate: formData.dueDate, // Todoの期限日
                status: TodoStatus(rawValue: formData.status) ?? .notStarted, // Todoのステータス
                order: viewModel.todos.count // Todoの順序（既存Todo数を基に設定）
            )

            // ビューモデルを通じてTodoを非同期で追加
            await viewModel.addTodo(todo)
        }
    }
}

#Preview {
    // プレビューでAddTodoViewを表示
    AddTodoView()
}
