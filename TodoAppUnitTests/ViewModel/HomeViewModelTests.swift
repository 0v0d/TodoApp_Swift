//
//  HomeViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!
    var repository: MockTodoRepository!

    override func setUp() {
        super.setUp()
        repository = MockTodoRepository()
        viewModel = HomeViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        repository = nil
        super.tearDown()
    }

    func testAddTodoSuccess() async {
        let todo = TodoTestData.todo

        await viewModel.addTodo(todo)

        XCTAssertEqual(viewModel.todos.count, 1)
        XCTAssertEqual(viewModel.todos.first?.title, TodoTestData.todo.title)
    }

    func testLoadTodosSuccess() async {
        repository.todos = TodoTestData.todos

        await viewModel.loadTodos()

        XCTAssertEqual(viewModel.todos.count, TodoTestData.todos.count)
        XCTAssertEqual(viewModel.todos[0].title, TodoTestData.todos[0].title)
    }

    func testMoveTodoSuccess() async {
        repository.todos = TodoTestData.todos

        await viewModel.moveTodo(from: IndexSet(integer: 0), end: 2)

        XCTAssertEqual(viewModel.todos[0], TodoTestData.todos[1])
        XCTAssertEqual(viewModel.todos[2], TodoTestData.todos[0] )
    }

    func testDeleteTodoSuccess() async {
        repository.todos = TodoTestData.todos

        await viewModel.deleteTodo(repository.todos[0])

        XCTAssertEqual(viewModel.todos.count, TodoTestData.todos.count - 1)
        XCTAssertEqual(viewModel.todos.first, TodoTestData.todos[1])
    }
}
