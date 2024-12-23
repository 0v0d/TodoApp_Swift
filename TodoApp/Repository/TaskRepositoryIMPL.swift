//
//  TaskRepositoryImpl.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import SwiftData
import Foundation

/// タスク管理リポジトリの実装クラス
final class TaskRepositoryIMPL: TaskRepository {
    /// モデルデータのコンテナ
    private let modelContainer: ModelContainer

    /// 初期化メソッド
    init() throws {
        // Todoモデルのスキーマを定義
        let schema = Schema([Todo.self])

        // データをメモリにのみ保存するかのフラグ
        #if DEBUG
        let inMemory = CommandLine.arguments.contains("testing")
        #else
        let inMemory = false
        #endif

        // モデルコンテナの初期化
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            throw error
        }
    }

    /// 全タスクを取得する
    ///
    /// - Returns: 全タスク「Todo」の配列
    @MainActor
    func fetchTasks() async throws -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.order)]) // 順序でソート
        return try modelContainer.mainContext.fetch(descriptor)
    }

    /// 新しいタスクを追加する
    ///
    /// - Parameter task: 追加するタスク
    /// - Throws: タスクの追加に失敗した場合
    @MainActor
    func addTask(_ task: Todo) async throws {
        modelContainer.mainContext.insert(task) // 新規タスクをコンテキストに挿入
        try modelContainer.mainContext.save()   // コンテキストを保存
    }

    /// 既存のタスクを更新する
    ///
    /// - Parameter task: 更新するタスク
    /// - Throws: タスクの更新に失敗した場合
    @MainActor
    func updateTask(_ task: Todo) async throws {
        try modelContainer.mainContext.save()   // 更新を保存
    }

    /// 指定したインデックスのタスクを削除する
    ///
    ///  - Parameter taskIndex: 削除するタスクのインデックス
    ///  - Throws: タスクの削除に失敗した場合
    @MainActor
    func deleteTask(taskIndex: IndexSet) async throws {
        let allTasks = try await fetchTasks() // 全タスクを取得
        for index in taskIndex {
            guard allTasks.indices.contains(index) else { continue } // インデックスが範囲外の場合はスキップ
            let taskToDelete = allTasks[index] // 削除対象のタスク
            modelContainer.mainContext.delete(taskToDelete)
        }
        try modelContainer.mainContext.save() // コンテキストを保存
    }

    /// タスクの順序を更新する
    ///
    /// - Parameters:
    ///  - from: 移動元のインデックス
    ///  - end: 移動先のインデックス
    ///  - Throws: タスクの順序の更新に失敗した場合
    @MainActor
    func updateOrder(from: Int, end: Int) async throws {
        var allTasks = try await fetchTasks() // 全タスクを取得
        guard allTasks.indices.contains(from) && end <= allTasks.count else { return }

        // 移動するタスクを取得
        let movedTask = allTasks[from]

        // 移動元からタスクを削除
        allTasks.remove(at: from)

        // 移動先にタスクを挿入（下方向への移動の場合は位置を調整）
        let adjustedDestination = end > from ? end - 1 : end
        allTasks.insert(movedTask, at: adjustedDestination)

        // すべてのタスクの順序を更新
        for (index, task) in allTasks.enumerated() {
            task.order = index
        }
        try modelContainer.mainContext.save() // コンテキストを保存
    }

    /// 全タスクを削除する
    ///
    /// - Throws: タスクの削除に失敗した場合
    /// - Note: テスト用
    @MainActor
    func deleteAllTasks() async throws {
        let allTasks = try await fetchTasks() // 全タスクを取得
        for task in allTasks {
            modelContainer.mainContext.delete(task)
        }
        try modelContainer.mainContext.save() // コンテキストを保存
    }
}
