//
//  TodoRepositoryImpl.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/30.
//
import SwiftData
import Foundation

/// Todo管理リポジトリの具体的な実装クラス
///
/// Todoデータの取得、追加、更新、削除、並び替えといった操作を提供します
/// データは内部で`ModelContainer`を使用して管理されます
///
/// - Note:
///  - テスト環境では、データをメモリ上にのみ保存します
///  - 実行時のコマンドライン引数に`"testing"`を含めることで動作を切り替えます
final class TodoRepositoryIMPL: TodoRepository {

    /// モデルデータのコンテナ
    ///
    /// - Note: Todoの保存や管理を行うためのデータコンテナ
    private let modelContainer: ModelContainer

    /// クラスのインスタンスを初期化する
    ///
    /// `Todo`モデルのスキーマを設定し、データ保存先を構成します
    ///
    /// - Note:
    /// - 実行時のコマンドライン引数に`"testing"`を含めることで動作を切り替えます
    /// - テスト環境では、データをメモリ上にのみ保存します
    /// - そのため、テスト時にはデータが永続化されず、テスト終了後にデータが破棄されます
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

    /// 全Todoを取得する
    ///
    /// - Note:データベース内のすべてのTodoを、順序に基づいてソートして取得します
    ///
    /// - Returns: 全Todo（`Todo`オブジェクト）の配列
    ///
    /// - Throws: データ取得に失敗した場合にエラーをスローします
    @MainActor
    func fetchTodos() async throws -> [Todo] {
        let descriptor = FetchDescriptor<Todo>(sortBy: [SortDescriptor(\.order)])
        return try modelContainer.mainContext.fetch(descriptor)
    }

    /// 新しいTodoを追加する
    ///
    /// - Parameter todo: 追加するTodo（`Todo`オブジェクト）
    ///
    /// - Throws: Todoの追加または保存に失敗した場合にエラーをスローします
    @MainActor
    func addTodo(_ todo: Todo) async throws {
        modelContainer.mainContext.insert(todo)
        try modelContainer.mainContext.save()
    }

    /// 既存のTodoを更新する
    ///
    /// - Parameter todo: 更新対象のTodo（`Todo`オブジェクト）
    /// - Throws: Todoの保存に失敗した場合にエラーをスローします
    @MainActor
    func updateTodo(_ todo: Todo) async throws {
        try modelContainer.mainContext.save()
    }

    /// 指定したインデックスのTodoを削除する
    ///
    /// - Note: Todo配列のインデックスを指定して、対応するTodoを削除します
    ///
    /// - Parameter todoIndex: 削除対象Todoのインデックスセット
    ///
    /// - Throws: Todoの削除または保存に失敗した場合にエラーをスローします
    @MainActor
    func deleteTodo(todoIndex: IndexSet) async throws {
        let allTodos = try await fetchTodos()
        for index in todoIndex {
            guard allTodos.indices.contains(index) else { continue }
            let todoToDelete = allTodos[index]
            modelContainer.mainContext.delete(todoToDelete)
        }
        try modelContainer.mainContext.save()
    }

    /// Todoの順序を更新する
    ///
    /// - Note: 指定したインデックス間でTodoを移動し、順序を更新します
    ///
    /// - Parameters:
    ///   - from: 移動元のインデックス
    ///   - end: 移動先のインデックス
    ///
    /// - Throws: Todoの並び替えまたは保存に失敗した場合にエラーをスローします
    @MainActor
    func updateOrder(from: Int, end: Int) async throws {
        var allTodos = try await fetchTodos()
        guard allTodos.indices.contains(from) && end <= allTodos.count else { return }

        let movedTodo = allTodos[from]
        allTodos.remove(at: from)
        let adjustedDestination = end > from ? end - 1 : end
        allTodos.insert(movedTodo, at: adjustedDestination)

        for (index, todo) in allTodos.enumerated() {
            todo.order = index
        }
        try modelContainer.mainContext.save()
    }

    ///  データベース内のすべてのTodoを削除します
    ///
    /// - Note: このメソッドは主にテスト目的で使用されます
    ///
    /// - Throws: Todoの削除または保存に失敗した場合にエラーをスローします
    @MainActor
    func deleteAllTodos() async throws {
        let allTodos = try await fetchTodos()
        for todo in allTodos {
            modelContainer.mainContext.delete(todo)
        }
        try modelContainer.mainContext.save()
    }
}
