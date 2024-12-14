//
//  TaskRepository.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import SwiftData
import Foundation

protocol TaskRepository {
    @MainActor func fetchTasks() async throws -> [Todo]
    @MainActor func addTask(_ task: Todo) async throws
    @MainActor func updateTask(_ task: Todo) async throws
    @MainActor func deleteTask(taskIndex: IndexSet) async throws
    @MainActor func updateOrder(from: Int, end: Int) async throws // タスクの順番を更新するメソッド
    @MainActor func deleteAllTasks() async throws
}

final class TaskRepositoryIMPL: TaskRepository {
    private let modelContainer: ModelContainer

    init() throws {
        let schema = Schema([Todo.self])

        var inMemory = false

        #if DEBUG
        if CommandLine.arguments.contains("testing") {
            inMemory = true
        }
        #endif

        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: inMemory)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            print("データベースの初期化に失敗しました: \(error.localizedDescription)")
            throw error
        }
    }

    @MainActor
    func fetchTasks() async throws -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.order)])
        return try modelContainer.mainContext.fetch(descriptor)
    }

    @MainActor
    func addTask(_ task: Todo) async throws {
        modelContainer.mainContext.insert(task)
        try modelContainer.mainContext.save()
    }

    @MainActor
    func updateTask(_ task: Todo) async throws {
        try modelContainer.mainContext.save()
    }

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

    // 特定のタスクを削除するメソッド
    @MainActor
    func deleteTask(_ task: Todo) async throws {
        modelContainer.mainContext.delete(task)
        try modelContainer.mainContext.save()
    }

    @MainActor
    func updateOrder(from: Int, end: Int) async throws {
        var allTasks = try await fetchTasks()
        guard allTasks.indices.contains(from) && end <= allTasks.count else { return }

        // 移動するタスクを取得
        let movedTask = allTasks[from]

        // 移動元から削除
        allTasks.remove(at: from)

        // 移動先に挿入（下方向への移動の場合は位置を調整）
        let adjustedDestination = end > from ? end - 1 : end
        allTasks.insert(movedTask, at: adjustedDestination)

        // すべてのタスクの順序を更新
        for (index, task) in allTasks.enumerated() {
            task.order = index
        }

        try modelContainer.mainContext.save()
    }

    @MainActor
    func deleteAllTasks() async throws {

        let allTasks = try await fetchTasks()
        for task in allTasks {
            modelContainer.mainContext.delete(task)
        }
        try modelContainer.mainContext.save()
    }
}
