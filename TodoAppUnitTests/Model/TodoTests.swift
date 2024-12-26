//
//  TodoTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

/// `Todo` モデルの動作を検証するテストクラス
///
/// このクラスでは、`Todo` モデルの初期化および更新メソッドが正しく動作するかをテストします
/// プロパティの正しい初期化、更新後のプロパティの変更を検証します
final class TodoTests: XCTestCase {

    /// `Todo` モデルの初期化が正しく行われることを検証
    ///
    /// - 期待結果: 初期化された `Todo` インスタンスのプロパティが、期待値と一致する
    func testTodoInitialization() {
        let todo = TodoTestData.todo
        XCTAssertEqual(todo.title, TodoTestData.todo.title)
        XCTAssertEqual(todo.comment, TodoTestData.todo.comment)
        XCTAssertEqual(todo.url, TodoTestData.todo.url)
        XCTAssertEqual(todo.timestamp, TodoTestData.todo.timestamp)
        XCTAssertEqual(todo.dueDate, TodoTestData.todo.dueDate)
        XCTAssertEqual(todo.status, TodoTestData.todo.status)
        XCTAssertEqual(todo.order, TodoTestData.todo.order)
    }

    /// `Todo` モデルの更新が正しく行われることを検証
    ///
    /// - 期待結果: 更新後の `Todo` インスタンスのプロパティが、新しい値に変更される
    func testTodoUpdate() {
        let todo = TodoTestData.todos[0]
        let newDueDate = Date()
        todo.update(
            title: "Updated Task",
            comment: "Updated comment",
            url: "https://www.google.co.jp/",
            dueDate: newDueDate,
            status: .completed
        )
        XCTAssertEqual(todo.title, "Updated Task")
        XCTAssertEqual(todo.comment, "Updated comment")
        XCTAssertEqual(todo.url, "https://www.google.co.jp/")
        XCTAssertEqual(todo.dueDate, newDueDate)
        XCTAssertEqual(todo.status, .completed)
    }
}
