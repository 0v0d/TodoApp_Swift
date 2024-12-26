//
//  TaskReorderingTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

final class TaskReorderingTests: XCTestCase {

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

    //// タスクの並び替えが正しく動作することを確認
    func testMoveTask() throws {
        let tasks =  (1...2).map { "Task \($0)" }

        utils.setupTasksForTesting(tasks: tasks)

        let taskCell = application.collectionViews.element(boundBy: 0).cells

        let initialFirstTask = taskCell.element(boundBy: 0).staticTexts[tasks[0]].label
        let initialSecondTask = taskCell.element(boundBy: 1).staticTexts[tasks[1]].label

        utils.tapEditButton()

        let firstTask = taskCell.element(boundBy: 0)
        firstTask.press(forDuration: 1, thenDragTo: taskCell.element(boundBy: 1))

        let doneButton = application.buttons[Identifiers.doneButton]
        doneButton.tap()

        let updatedFirstTask = taskCell.element(boundBy: 0).staticTexts[tasks[1]].label
        let updatedSecondTask = taskCell.element(boundBy: 1).staticTexts[tasks[0]].label

        assertEqualsTaskTitle(updatedFirstTask, initialSecondTask)
        assertEqualsTaskTitle(updatedSecondTask, initialFirstTask)
    }
}

extension TaskReorderingTests {
    /// タスクのタイトルが一致するかを検証
    /// - Parameters:
    ///  - firstTaskTitle: 比較対象のタスクタイトル
    ///  - expectedTaskTitle: 期待するタスクタイトル
    private func assertEqualsTaskTitle(_ firstTaskTitle: String, _ expectedTaskTitle: String) {
        XCTAssertEqual(firstTaskTitle, expectedTaskTitle, "Task Title should be equal")
    }
}
