//
//  TaskRepositoryTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

/// `TaskRepositoryIMPL` の動作を検証するテストクラス
///
/// このクラスでは、`TaskRepositoryIMPL` の主要な機能（タスクの追加、取得、削除、更新、順序変更）を検証します。
/// テストデータを使用してリポジトリの動作が期待通りであることを確認します。
final class TaskRepositoryTests: XCTestCase {

    /// テスト対象のタスクリポジトリのインスタンス
    private var taskRepository: TaskRepositoryIMPL!

    /// 各テストのセットアップ処理
    ///
    /// タスクリポジトリを初期化し、すべてのタスクを削除してクリーンな状態を確保します。
    override func setUp() async throws {
        taskRepository = try TaskRepositoryIMPL()
        try await taskRepository.deleteAllTasks()
    }

    /// 各テストの後処理
    ///
    /// すべてのタスクを削除し、リポジトリインスタンスを破棄します。
    override func tearDown() async throws {
        try await taskRepository.deleteAllTasks()
        taskRepository = nil
    }

    /// 複数のタスクを追加する共通ヘルパーメソッド
    ///
    /// - Parameter tasks: 追加するタスクの配列
    private func addTasks(_ tasks: [Todo]) async throws {
        for task in tasks {
            try await taskRepository.addTask(task)
        }
    }

    /// タスクの追加が成功することを検証
    ///
    /// - 期待結果: タスクがリポジトリに正しく追加され、取得結果に反映される。
    func testAddTask() async throws {
        try await taskRepository.addTask(TodoTestData.todo)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks, [TodoTestData.todo])
    }

    /// 複数のタスクを追加して正常に取得できることを検証
    ///
    /// - 期待結果: 追加したすべてのタスクが取得され、順序も保持されている。
    func testFetchTasks() async throws {
        try await addTasks(TodoTestData.todos)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, TodoTestData.todos.count)
        XCTAssertEqual(tasks, TodoTestData.todos)
    }

    /// タスクの削除が成功することを検証
    ///
    /// - 期待結果: 指定したタスクが削除され、残りのタスクが正しい順序で保持される。
    func testDeleteTask() async throws {
        try await addTasks(TodoTestData.todos)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, TodoTestData.todos.count)

        try await taskRepository.deleteTask(taskIndex: IndexSet(integer: 0))

        let updatedTasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(updatedTasks.count, TodoTestData.todos.count - 1)
        for ite in 0..<updatedTasks.count {
            XCTAssertEqual(updatedTasks[ite], TodoTestData.todos[ite+1])
        }
    }

    /// タスクの更新が成功することを検証
    ///
    /// - 期待結果: 指定したタスクの内容が正しく更新される。
    func testUpdateTask() async throws {
        let task = TodoTestData.todo
        try await addTasks([task])

        // タスクを更新
        task.title = "Updated Task"
        try await taskRepository.updateTask(task)

        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.title, "Updated Task")
    }

    /// タスク順序の更新がエッジケースでも正しく機能することを検証
    ///
    /// - 期待結果: 最後のタスクが最初に移動し、順序が期待通りに更新される。
    func testUpdateOrderEdgeCase() async throws {
        try await addTasks(TodoTestData.todos)

        // 最後のタスクを最初に移動
        try await taskRepository.updateOrder(from: 2, end: 0)
        let tasks = try await taskRepository.fetchTasks()

        XCTAssertEqual(tasks.count, 7)
        XCTAssertEqual(tasks, [
            TodoTestData.todos[2],
            TodoTestData.todos[0],
            TodoTestData.todos[1],
            TodoTestData.todos[3],
            TodoTestData.todos[4],
            TodoTestData.todos[5],
            TodoTestData.todos[6]
        ])
    }
}
