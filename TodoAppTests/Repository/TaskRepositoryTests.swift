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
        try await taskRepository.addTask(TestData.todo)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks, [TestData.todo])
    }

    func testFetchTasks() async throws {
        try await addTasks(TestData.todos)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, TestData.todos.count)
        XCTAssertEqual(tasks, TestData.todos)
    }

    func testDeleteTask() async throws {
        try await addTasks(TestData.todos)
        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, TestData.todos.count)

        try await taskRepository.deleteTask(taskIndex: IndexSet(integer: 0))

        let updatedTasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(updatedTasks.count, TestData.todos.count - 1)
        for ite in 0..<updatedTasks.count {
            XCTAssertEqual(updatedTasks[ite], TestData.todos[ite+1])
        }
    }

    func testUpdateTask() async throws {
        let task = TestData.todo
        try await addTasks([task])

        // タスクを更新
        task.title = "Updated Task"
        try await taskRepository.updateTask(task)

        let tasks = try await taskRepository.fetchTasks()
        XCTAssertEqual(tasks.count, 1)
        XCTAssertEqual(tasks.first?.title, "Updated Task")
    }

    func testUpdateOrderEdgeCase() async throws {
        try await addTasks(TestData.todos)

        // 最後のタスクを最初に移動
        try await taskRepository.updateOrder(from: 2, end: 0)
        let tasks = try await taskRepository.fetchTasks()

        XCTAssertEqual(tasks.count, 7)
        XCTAssertEqual(tasks, [
            TestData.todos[2],
            TestData.todos[0],
            TestData.todos[1],
            TestData.todos[3],
            TestData.todos[4],
            TestData.todos[5],
            TestData.todos[6]
        ])
    }

}
