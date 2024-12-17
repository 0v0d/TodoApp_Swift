//
//  WidgetTaskViewModelTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/03.
//
import XCTest
@testable import TodoApp

final class WidgetTaskViewModelTests: XCTestCase {
    private var viewModel: WidgetTaskViewModel!
    private let repository: MockTaskRepository = MockTaskRepository()

    override func setUp() {
        super.setUp()
        viewModel = WidgetTaskViewModel(repository: repository)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testFetchActiveTaskWithActiveTasks() async throws {
        repository.tasks = TodoTestData.todos
        let activeTask = try await viewModel.fetchActiveTask()

        XCTAssertEqual(activeTask?.title, TodoTestData.todos[3].title)
    }

    func testFetchActiveTaskWithAllTasksCompleted() async throws {
        repository.tasks = TodoTestData.completeTodos
        let activeTask = try await viewModel.fetchActiveTask()
        XCTAssertNil(activeTask)
    }

    func testFetchActiveTaskWithNoTasks() async throws {
        repository.tasks = []
        let activeTask = try await viewModel.fetchActiveTask()
        XCTAssertNil(activeTask)
    }

    func testFetchActiveTaskWhenRepositoryThrowsError() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "Fetch Error"])

        do {
            _ = try await viewModel.fetchActiveTask()
            XCTFail("Error")
        } catch {
            XCTAssertEqual((error as NSError).domain, "TestError")
            XCTAssertEqual((error as NSError).localizedDescription, "Fetch Error")
        }
    }
}
