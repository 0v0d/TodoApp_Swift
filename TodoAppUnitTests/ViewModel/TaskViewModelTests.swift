//
//  TaskViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

final class TaskViewModelTests: XCTestCase {
    var viewModel: TaskViewModel!
    var repository: MockTaskRepository!

    override func setUp() {
        super.setUp()
        repository = MockTaskRepository()
        viewModel = TaskViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func testAddTaskSuccess() async {
        let task = TodoTestData.todo

        await viewModel.addTask(task)

        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, TodoTestData.todo.title)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showingErrorAlert)
    }

    func testAddTaskFailure() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "AddTask Error"])

        let task = TodoTestData.todo

        await viewModel.addTask(task)

        XCTAssertEqual(viewModel.tasks.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "AddTask Error")
        XCTAssertTrue(viewModel.showingErrorAlert)
    }

    func testLoadTasksSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.loadTasks()

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count)
        XCTAssertEqual(viewModel.tasks[0].title, TodoTestData.todos[0].title)
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showingErrorAlert)
    }

    func testLoadTasksFailure() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "LoadTasks Error"])

        await viewModel.loadTasks()

        XCTAssertTrue(viewModel.tasks.isEmpty)
        XCTAssertEqual(viewModel.errorMessage, "LoadTasks Error")
        XCTAssertTrue(viewModel.showingErrorAlert)
    }

    func testMoveTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.moveTask(from: IndexSet(integer: 0), end: 2)

        XCTAssertEqual(viewModel.tasks[0], TodoTestData.todos[1])
        XCTAssertEqual(viewModel.tasks[2], TodoTestData.todos[0])
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showingErrorAlert)
    }

    func testMoveTaskFailure() async {
        repository.tasks = TodoTestData.todos
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "MoveTask Error"])

        await viewModel.moveTask(from: IndexSet(integer: 0), end: 2)

        XCTAssertEqual(viewModel.errorMessage, "MoveTask Error")
        XCTAssertTrue(viewModel.showingErrorAlert)
    }

    func testDeleteTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.deleteTask(repository.tasks[0])

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count - 1)
        XCTAssertEqual(viewModel.tasks.first, TodoTestData.todos[1])
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.showingErrorAlert)
    }

    func testDeleteTaskFailure() async {
        repository.tasks = TodoTestData.todos
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "DeleteTask Error"])

        await viewModel.deleteTask(repository.tasks[0])

        XCTAssertEqual(viewModel.errorMessage, "DeleteTask Error")
        XCTAssertTrue(viewModel.showingErrorAlert)
    }

    // エラーハンドリングのテスト
    func testHandleError() async {
        let testError = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Test Error Message"])

        // private メソッドを直接テストする代わりに、エラーを発生させる操作を実行
        repository.error = testError
        await viewModel.loadTasks()

        XCTAssertTrue(viewModel.showingErrorAlert)
        XCTAssertEqual(viewModel.errorMessage, "Test Error Message")
    }
}
