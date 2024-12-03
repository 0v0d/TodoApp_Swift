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
    
    func testAddTask_success() async {
        let task = TestData.todo
        
        await viewModel.addTask(task)
        
        XCTAssertEqual(viewModel.tasks.count, 1)
        XCTAssertEqual(viewModel.tasks.first?.title, TestData.todo.title)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testAddTask_failure() async {
        repository.error = NSError(
            domain: "TestError",
            code: 1,
            userInfo: [NSLocalizedDescriptionKey: "AddTask Error"])
        
        let task = TestData.todo
        
        await viewModel.addTask(task)
        
        XCTAssertEqual(viewModel.tasks.count, 0)
        XCTAssertEqual(viewModel.errorMessage, "AddTask Error")
    }
    
    func testLoadTasks_success() async {
        repository.tasks = TestData.todos
        
        await viewModel.loadTasks()
        
        XCTAssertEqual(viewModel.tasks.count, TestData.todos.count)
        XCTAssertEqual(viewModel.tasks[0].title, TestData.todos[0].title)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testMoveTask_success() async {
        repository.tasks = TestData.todos
        
        await viewModel.moveTask(from: IndexSet(integer: 0), end: 2)
        
        XCTAssertEqual(viewModel.tasks[0], TestData.todos[1])
        XCTAssertEqual(viewModel.tasks[2],TestData.todos[0] )
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testDeleteTask_success() async {
        repository.tasks = TestData.todos
        
        await viewModel.deleteTask(repository.tasks[0])
        
        XCTAssertEqual(viewModel.tasks.count,TestData.todos.count - 1)
        XCTAssertEqual(viewModel.tasks.first,TestData.todos[1])
        XCTAssertNil(viewModel.errorMessage)
    }
}
