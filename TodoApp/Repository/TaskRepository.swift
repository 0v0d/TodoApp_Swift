//
//  TaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/22.
//
import Foundation

/// タスク管理リポジトリのプロトコル
protocol TaskRepository {
    /// 全タスクを非同期で取得する
    @MainActor func fetchTasks() async throws -> [Todo]

    /// タスクを追加する
    @MainActor func addTask(_ task: Todo) async throws

    /// タスクを更新する
    @MainActor func updateTask(_ task: Todo) async throws

    /// 指定したインデックスのタスクを削除する
    @MainActor func deleteTask(taskIndex: IndexSet) async throws

    /// タスクの順序を更新する
    @MainActor func updateOrder(from: Int, end: Int) async throws

    /// 全タスクを削除する
    @MainActor func deleteAllTasks() async throws
}
