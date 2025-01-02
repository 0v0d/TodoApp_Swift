//
//  HomeView+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//

import Foundation

extension HomeView {
    /// Todoの一覧を読み込む処理
    func loadTodos() {
        Task {
            await viewModel.loadTodos() // 非同期でTodoをロード
        }
    }

    /// 指定したインデックスのTodoを削除する処理
    ///
    /// - Parameter offsets: 削除対象のインデックスセット
    func deleteTodo(offsets: IndexSet) {
        Task {
            for index in offsets {
                let todo = viewModel.todos[index]
                await viewModel.deleteTodo(todo) // 非同期で削除
            }
        }
    }

    /// Todoを並び替える処理
    ///
    /// - Parameters:
    ///   - from: 移動元のインデックスセット
    ///   - end: 移動先のインデックス
    func moveTodo(from: IndexSet, end: Int) {
        Task {
            await viewModel.moveTodo(from: from, end: end)
        }
    }
}
