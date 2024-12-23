//
//  TaskViewModel.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import Foundation

/// タスクを管理するビューモデル
final class TaskViewModel: ObservableObject {
    /// タスクデータのリポジトリ
    private let repository: TaskRepository

    /// タスクのリストを公開プロパティとして保持
    @Published var tasks: [Todo] = []

    /// 初期化メソッド
    /// - Parameter repository: タスクのデータを管理するリポジトリ
    init(repository: TaskRepository) {
        self.repository = repository
    }

    /// タスクを追加する非同期メソッド
    ///
    /// - Parameter task: 追加するタスク
    @MainActor
    func addTask(_ task: Todo) async {
        do {
            // リポジトリを通じてタスクを追加
            try await repository.addTask(task)
            // タスクのリストを再読み込み
            await loadTasks()  // データ更新の冗長性を回避
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// タスクを更新する非同期メソッド
    ///
    /// - Parameter task: 更新するタスク
    @MainActor
    func updateTask(_ task: Todo) async {
        do {
            // リポジトリを通じてタスクを更新
            try await repository.updateTask(task)
            // タスクのリストを再読み込み
            await loadTasks()
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// タスクを取得し、リストを更新する非同期メソッド
    @MainActor
    func loadTasks() async {
        do {
            // リポジトリからタスクのリストを取得
            tasks = try await repository.fetchTasks()
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// タスクの並び順を変更する非同期メソッド
    ///
    /// - Parameters:
    ///   - source: 元の位置
    ///   - destination: 移動先の位置
    @MainActor
    func moveTask(from source: IndexSet, end destination: Int) async {
        do {
            // IndexSetから最初のインデックスを取得
            guard let sourceIndex = source.first else { return }
            // リポジトリで順序を更新
            try await repository.updateOrder(from: sourceIndex, end: destination)
            // タスクのリストを再読み込み
            await loadTasks()
        } catch {
            // エラーをログに記録
            handle(error: error)
        }
    }

    /// タスクを削除する非同期メソッド
    ///
    /// - Parameter task: 削除するタスク
    @MainActor
    func deleteTask(_ task: Todo) async {
        do {
            // サーバーからすべてのタスクを取得
            let allTasks = try await repository.fetchTasks()
            // 削除対象のタスクのインデックスを取得
            if let index = allTasks.firstIndex(of: task) {
                // インデックスを IndexSet に変換
                let taskIndex = IndexSet(integer: index)
                // リポジトリで削除処理を実行
                try await repository.deleteTask(taskIndex: taskIndex)
                // タスクのリストを再読み込み
                await loadTasks()
            }
        } catch {
            // エラーを処理
            handle(error: error)
        }
    }

    /// エラーを処理してエラーメッセージを設定
    ///
    /// - Parameter error: 発生したエラー
    /// - Note: エラーが頻繁に発生する場合は、UI側に表示するように変更
    private func handle(error: Error) {
        print("Error: \(error)")
    }
}
