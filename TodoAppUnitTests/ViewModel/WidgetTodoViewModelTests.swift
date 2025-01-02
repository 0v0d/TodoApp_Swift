//
//  WidgetTodoViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

final class WidgetTodoViewModelTests: XCTestCase {
    private var viewModel: WidgetTodoViewModel!
    private let repository: MockTodoRepository = MockTodoRepository()

    override func setUp() {
        super.setUp()
        viewModel = WidgetTodoViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchActiveTodoWithActiveTodos() async throws {
        repository.todos = TodoTestData.todos
        let activeTodo = try await viewModel.fetchActiveTodo()

        XCTAssertEqual(activeTodo?.title, TodoTestData.todos[3].title)
    }

    func testFetchActiveTodoWithAllTodosCompleted() async throws {
        repository.todos = TodoTestData.completeTodos
        let activeTodo = try await viewModel.fetchActiveTodo()
        XCTAssertNil(activeTodo)
    }

    func testFetchActiveTodoWithNoTodos() async throws {
        repository.todos = []
        let activeTodo = try await viewModel.fetchActiveTodo()
        XCTAssertNil(activeTodo)
    }

    func testFetchActiveTodoWhenRepositoryThrowsError() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Fetch Error"])

        do {
            _ = try await viewModel.fetchActiveTodo()
            XCTFail("Error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
            XCTAssertEqual((error as NSError).localizedDescription, "Fetch Error")
        }
    }
}
