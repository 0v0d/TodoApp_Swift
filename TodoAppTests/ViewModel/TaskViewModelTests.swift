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
    }

    func testLoadTasksSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.loadTasks()

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count)
        XCTAssertEqual(viewModel.tasks[0].title, TodoTestData.todos[0].title)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testMoveTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.moveTask(from: IndexSet(integer: 0), end: 2)

        XCTAssertEqual(viewModel.tasks[0], TodoTestData.todos[1])
        XCTAssertEqual(viewModel.tasks[2], TodoTestData.todos[0] )
        XCTAssertNil(viewModel.errorMessage)
    }

    func testDeleteTaskSuccess() async {
        repository.tasks = TodoTestData.todos

        await viewModel.deleteTask(repository.tasks[0])

        XCTAssertEqual(viewModel.tasks.count, TodoTestData.todos.count - 1)
        XCTAssertEqual(viewModel.tasks.first, TodoTestData.todos[1])
        XCTAssertNil(viewModel.errorMessage)
    }
}
