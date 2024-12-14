import XCTest
import SwiftData
@testable import TodoApp

final class TaskRepositoryTests: XCTestCase {
    private var taskRepository: TaskRepositoryIMPL!

    override func setUp() async throws {
        taskRepository = try TaskRepositoryIMPL()
        try await taskRepository.deleteAllTasks()
    }

    override func tearDown() async throws {
        try await taskRepository.deleteAllTasks()
        taskRepository = nil
    }

    // 共通のタスク追加メソッド
    private func addTasks(_ tasks: [Todo]) async throws {
        for task in tasks {
            try await taskRepository.addTask(task)
        }
    }

    func testAddTask() async throws {
        try await taskRepository.addTask(TodoTestData.todo)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks, [TodoTestData.todo])
    }

    func testFetchTasks() async throws {
        try await addTasks(TodoTestData.todos)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, TodoTestData.todos.count)
        XCTAssertEqual(tasks, TodoTestData.todos)
    }

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
