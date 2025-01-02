//
//  TodoReorderingTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

final class TodoReorderingTests: XCTestCase {

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

    //// Todoの並び替えが正しく動作することを確認
    func testMoveTodo() throws {
        let todos =  (1...2).map { "Todo \($0)" }

        utils.setupTodosForTesting(todos: todos)

        let todoCell = application.collectionViews.element(boundBy: 0).cells

        let initialFirstTodo = todoCell.element(boundBy: 0).staticTexts[todos[0]].label
        let initialSecondTodo = todoCell.element(boundBy: 1).staticTexts[todos[1]].label

        utils.tapEditButton()

        let firstTodo = todoCell.element(boundBy: 0)
        firstTodo.press(forDuration: 1, thenDragTo: todoCell.element(boundBy: 1))

        let doneButton = application.buttons[Identifiers.doneButton]
        doneButton.tap()

        let updatedFirstTodo = todoCell.element(boundBy: 0).staticTexts[todos[1]].label
        let updatedSecondTodo = todoCell.element(boundBy: 1).staticTexts[todos[0]].label

        assertEqualsTodoTitle(updatedFirstTodo, initialSecondTodo)
        assertEqualsTodoTitle(updatedSecondTodo, initialFirstTodo)
    }
}

extension TodoReorderingTests {
    /// Todoのタイトルが一致するかを検証
    /// - Parameters:
    ///  - firstTodoTitle: 比較対象のTodoタイトル
    ///  - expectedTodoTitle: 期待するTodoタイトル
    private func assertEqualsTodoTitle(_ firstTodoTitle: String, _ expectedTodoTitle: String) {
        XCTAssertEqual(firstTodoTitle, expectedTodoTitle, "Todo Title should be equal")
    }
}
