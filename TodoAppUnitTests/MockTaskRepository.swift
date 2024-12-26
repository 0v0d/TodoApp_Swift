//
//  MockTaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import Foundation
@testable import TodoApp

/// モック実装のタスクリポジトリ
///
/// テスト用に使用される `TaskRepository` のモック実装です
/// 非同期で動作するメソッドを提供し、テスト中にエラーを注入することで例外処理の検証も可能です
///
/// - Note: テスト用途でのみ使用されるため、`@MainActor`属性は付けられていません
///
/// - parameters:
///  - tasks: 保持するタスクのリスト
///  - error: エラーを注入するためのプロパティ
class MockTaskRepository: TaskRepository {

    var tasks: [Todo] = []

    var error: Error?

    /// タスクを追加します
    ///
    /// - Parameter task: 追加するタスク
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    func addTask(_ task: Todo) async throws {
        if let error = error {
            throw error
        }
        tasks.append(task)
    }

    /// タスクを更新します
    ///
    /// - Parameter task: 更新するタスク
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    /// タスクがリスト内に存在する場合、その内容を更新します
    func updateTask(_ task: Todo) async throws {
        if let error = error {
            throw error
        }
        if let index = tasks.firstIndex(of: task) {
            tasks[index] = task
        }
    }

    /// すべてのタスクを取得します
    ///
    /// - Returns: 現在保持しているすべてのタスク
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    func fetchTasks() async throws -> [Todo] {
        if let error = error {
            throw error
        }
        return tasks
    }

    /// タスクの順序を更新します
    ///
    /// - Parameters:
    ///   - source: 移動元のインデックス
    ///   - destination: 移動先のインデックス
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    func updateOrder(from source: Int, end destination: Int) async throws {
        if let error = error {
            throw error
        }
        let movedTask = tasks.remove(at: source)
        tasks.insert(movedTask, at: destination)
    }

    /// 指定されたインデックスのタスクを削除します
    ///
    /// - Parameter taskIndex: 削除するタスクのインデックスセット
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    func deleteTask(taskIndex: IndexSet) async throws {
        if let error = error {
            throw error
        }
        guard let index = taskIndex.first else { return }
        tasks.remove(at: index)
    }

    /// すべてのタスクを削除します
    ///
    /// - Throws: `error` が設定されている場合、そのエラーをスローします
    func deleteAllTasks() async throws {
        if let error = error {
            throw error
        }
        tasks.removeAll()
    }
}
