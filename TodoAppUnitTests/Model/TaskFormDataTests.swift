//
//  TaskFormDataTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/01.
//
import XCTest
@testable import TodoApp

/// `TaskFormData` の動作を検証するテストクラス
///
/// このクラスでは、`TaskFormData` のデフォルト初期化や、
/// `Todo` モデルからの初期化が正しく動作するかをテストします
final class TaskFormDataTests: XCTestCase {

    /// `TaskFormData` のデフォルト初期化が正しく行われることを検証
    ///
    /// - 期待結果: 初期化された `TaskFormData` インスタンスのプロパティが、期待値と一致する
    func testTaskFormDataDefaultInitialization() {
        let taskFormData = TaskFormData()
        XCTAssertEqual(taskFormData.title, "")
        XCTAssertEqual(taskFormData.comment, "")
        XCTAssertEqual(taskFormData.url, "")
        XCTAssertNil(taskFormData.dueDate)
        XCTAssertEqual(taskFormData.status, 0)
    }

    /// `Todo` モデルを元に `TaskFormData` を初期化した場合に正しい値を持つことを検証
    ///
    /// - 期待結果: `Todo` モデルのプロパティが正しく `TaskFormData` にマッピングされる
    func testTaskFormDataInitializationFromTodo() {
        let todo = TodoTestData.todo
        let taskFormData = TaskFormData(from: todo)
        XCTAssertEqual(taskFormData.title, todo.title)
        XCTAssertEqual(taskFormData.comment, todo.comment)
        XCTAssertEqual(taskFormData.url, todo.url)
        XCTAssertEqual(taskFormData.dueDate, todo.dueDate)
        XCTAssertEqual(taskFormData.status, todo.status.rawValue)
    }
}
