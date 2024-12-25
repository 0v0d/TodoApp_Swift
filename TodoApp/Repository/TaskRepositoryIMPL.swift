//
//  TaskRepositoryImpl.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import SwiftData
import Foundation

/// タスク管理リポジトリの具体的な実装クラス
///
/// タスクデータの取得、追加、更新、削除、並び替えといった操作を提供します
/// データは内部で`ModelContainer`を使用して管理されます
///
/// - Note:
///  - テスト環境では、データをメモリ上にのみ保存します
///  - 実行時のコマンドライン引数に`"testing"`を含めることで動作を切り替えます
final class TaskRepositoryIMPL: TaskRepository {

    /// モデルデータのコンテナ
    ///
    /// タスクの保存や管理を行うためのデータコンテナ
    private let modelContainer: ModelContainer

    /// クラスのインスタンスを初期化する
    ///
    /// `Todo`モデルのスキーマを設定し、データ保存先を構成します
    ///
    /// - Throws: コンテナの初期化に失敗した場合にエラーをスローします
    init() throws {
        let schema = Schema([Todo.self])
        #if DEBUG
        let inMemory = CommandLine.arguments.contains("testing")
        #else
        let inMemory = false
        #endif
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            throw error
        }
    }

    /// 全タスクを取得する
    ///
    /// データベース内のすべてのタスクを、順序に基づいてソートして取得します
    ///
    /// - Returns: 全タスク（`Todo`オブジェクト）の配列
    /// - Throws: データ取得に失敗した場合にエラーをスローします
    @MainActor
    func fetchTasks() async throws -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.order)])
        return try modelContainer.mainContext.fetch(descriptor)
    }

    /// 新しいタスクを追加する
    ///
    /// 指定されたタスクをデータコンテナに挿入して保存します
    ///
    /// - Parameter task: 追加するタスク（`Todo`オブジェクト）
    /// - Throws: タスクの追加または保存に失敗した場合にエラーをスローします
    @MainActor
    func addTask(_ task: Todo) async throws {
        modelContainer.mainContext.insert(task)
        try modelContainer.mainContext.save()
    }

    /// 既存のタスクを更新する
    ///
    /// 変更されたタスクを保存します
    ///
    /// - Parameter task: 更新対象のタスク（`Todo`オブジェクト）
    /// - Throws: タスクの保存に失敗した場合にエラーをスローします
    @MainActor
    func updateTask(_ task: Todo) async throws {
        try modelContainer.mainContext.save()
    }

    /// 指定したインデックスのタスクを削除する
    ///
    /// タスク配列のインデックスを指定して、対応するタスクを削除します
    ///
    /// - Parameter taskIndex: 削除対象タスクのインデックスセット
    /// - Throws: タスクの削除または保存に失敗した場合にエラーをスローします
    @MainActor
    func deleteTask(taskIndex: IndexSet) async throws {
        let allTasks = try await fetchTasks()
        for index in taskIndex {
            guard allTasks.indices.contains(index) else { continue }
            let taskToDelete = allTasks[index]
            modelContainer.mainContext.delete(taskToDelete)
        }
        try modelContainer.mainContext.save()
    }

    /// タスクの順序を更新する
    ///
    /// 指定したインデックス間でタスクを移動し、順序を更新します
    ///
    /// - Parameters:
    ///   - from: 移動元のインデックス
    ///   - end: 移動先のインデックス
    /// - Throws: タスクの並び替えまたは保存に失敗した場合にエラーをスローします
    @MainActor
    func updateOrder(from: Int, end: Int) async throws {
        var allTasks = try await fetchTasks()
        guard allTasks.indices.contains(from) && end <= allTasks.count else { return }

        let movedTask = allTasks[from]
        allTasks.remove(at: from)
        let adjustedDestination = end > from ? end - 1 : end
        allTasks.insert(movedTask, at: adjustedDestination)

        for (index, task) in allTasks.enumerated() {
            task.order = index
        }
        try modelContainer.mainContext.save()
    }

    /// 全タスクを削除する
    ///
    /// データベース内のすべてのタスクを削除します
    ///
    /// - Throws: タスクの削除または保存に失敗した場合にエラーをスローします
    /// - Note: このメソッドは主にテスト目的で使用されます
    @MainActor
    func deleteAllTasks() async throws {
        let allTasks = try await fetchTasks()
        for task in allTasks {
            modelContainer.mainContext.delete(task)
        }
        try modelContainer.mainContext.save()
    }
}
