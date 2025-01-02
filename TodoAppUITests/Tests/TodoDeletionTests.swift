//
//  TodoDeletionTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

/// Todo削除に関するテスト
final class TodoDeletionTests: XCTestCase {

    private var application: XCUIApplication!

    private var utils: UITestUtils!

    /// テスト実行前のセットアップ処理
    ///
    /// アプリケーションの起動や、テストで使用するユーティリティクラスの初期化を行います
    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)
    }

    /// テスト実行後のクリーンアップ処理
    ///
    /// アプリケーションの終了や、関連リソースの解放を行います
    override func tearDown() {
        teardownUITest(application)
        application = nil
        super.tearDown()
    }

    /// Todoを削除する操作が正しく動作することを確認
    @MainActor
    func testDeleteSingleTodo() throws {
        utils.setupTodosForTesting()

        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        let todoList = application.collectionViews.element(boundBy: 0)
        let todoCell = todoList.cells.element(boundBy: 0)
        utils.assertElementExists(todoCell, exists: true)

        let deleteIconButton = todoCell.images[Identifiers.deleteButtonIcon]
        utils.assertElementExists(deleteIconButton, exists: true)
        deleteIconButton.tap()

        tapDeleteButton()

        utils.assertElementExists(todoCell, exists: false)
    }

    //// 左スワイプでTodoを削除する操作が正しく動作することを確認
    @MainActor
    func testSwipeDeleteSingleTodo() throws {
        utils.setupTodosForTesting()

        let todoList = application.collectionViews.element(boundBy: 0)
        let todoCell = todoList.cells.element(boundBy: 0)

        todoCell.swipeLeft()
        tapDeleteButton()

        utils.assertElementExists(todoCell, exists: false)
    }

    /// 複数のTodoを同時に削除できる
    @MainActor
    func testDeleteMultipleTodos() {
        let todos =  (0..<3).map { "Todo \($0)" }

        utils.setupTodosForTesting( todos: todos)
        let todoList = application.collectionViews.element(boundBy: 0)
        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        for _ in 0..<3 {
            let todoCell = todoList.cells.element(boundBy: 0)
            let deleteIconButton = todoCell.images[Identifiers.deleteButtonIcon]
            utils.assertElementExists(deleteIconButton, exists: true)
            deleteIconButton.tap()

            tapDeleteButton()
        }

        XCTAssertFalse(todoList.cells.count > 0, "All todos should be deleted")
        utils.assertStaticText(identifier: Identifiers.emptyTitle, value: nil)
        utils.assertStaticText(identifier: Identifiers.emptyMessage, value: nil)
    }

    /// 削除操作をキャンセルした場合の動作
    @MainActor
    func testCancelTodoDeletion() {
        utils.setupTodosForTesting()

        let todoList = application.collectionViews.element(boundBy: 0)
        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        let todoCell = todoList.cells.element(boundBy: 0)
        let deleteIconButton = todoCell.images[Identifiers.deleteButtonIcon]
        deleteIconButton.tap()

        application.buttons["Done"].tap()

        utils.assertElementExists(todoCell, exists: true)
    }

}

extension TodoDeletionTests {
    private func tapDeleteButton() {
        let deleteButton = application.buttons[Identifiers.deleteButton]
        utils.assertElementExists(deleteButton, exists: true)
        deleteButton.tap()
    }
}
