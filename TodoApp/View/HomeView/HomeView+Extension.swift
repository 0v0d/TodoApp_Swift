//
//  HomeView+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//

import Foundation

extension HomeView {
    /// タスクの一覧を読み込む処理
    func loadTasks() {
        Task {
            await viewModel.loadTasks() // 非同期でタスクをロード
        }
    }

    /// 指定したインデックスのタスクを削除する処理
    ///
    /// - Parameter offsets: 削除対象のインデックスセット
    func deleteTask(offsets: IndexSet) {
        Task {
            for index in offsets {
                let task = viewModel.tasks[index]
                await viewModel.deleteTask(task) // 非同期で削除
            }
        }
    }

    /// タスクを並び替える処理
    /// - Parameters:
    ///   - from: 移動元のインデックスセット
    ///   - end: 移動先のインデックス
    func moveTask(from: IndexSet, end: Int) {
        Task {
            await viewModel.moveTask(from: from, end: end) // 非同期で並び替え
        }
    }
}
