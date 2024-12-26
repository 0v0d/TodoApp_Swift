//
//  TaskDeletionTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

/// タスク削除に関するテスト
final class TaskDeletionTests: XCTestCase {

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

    /// タスクを削除する操作が正しく動作することを確認
    @MainActor
    func testDeleteSingleTask() throws {
        utils.setupTasksForTesting()

        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)
        utils.assertElementExists(taskCell, exists: true)

        let deleteIconButton = taskCell.images[Identifiers.deleteButtonIcon]
        utils.assertElementExists(deleteIconButton, exists: true)
        deleteIconButton.tap()

        tapDeleteButton()

        utils.assertElementExists(taskCell, exists: false)
    }

    //// 左スワイプでタスクを削除する操作が正しく動作することを確認
    @MainActor
    func testSwipeDeleteSingleTask() throws {
        utils.setupTasksForTesting()

        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)

        taskCell.swipeLeft()
        tapDeleteButton()

        utils.assertElementExists(taskCell, exists: false)
    }

    /// 複数のタスクを同時に削除できる
    @MainActor
    func testDeleteMultipleTasks() {
        let tasks =  (0..<3).map { "Task \($0)" }

        utils.setupTasksForTesting( tasks: tasks)
        let taskList = application.collectionViews.element(boundBy: 0)
        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        for _ in 0..<3 {
            let taskCell = taskList.cells.element(boundBy: 0)
            let deleteIconButton = taskCell.images[Identifiers.deleteButtonIcon]
            utils.assertElementExists(deleteIconButton, exists: true)
            deleteIconButton.tap()

            tapDeleteButton()
        }

        XCTAssertFalse(taskList.cells.count > 0, "All tasks should be deleted")
        utils.assertStaticText(identifier: Identifiers.emptyTitle, value: nil)
        utils.assertStaticText(identifier: Identifiers.emptyMessage, value: nil)
    }

    /// 削除操作をキャンセルした場合の動作
    @MainActor
    func testCancelTaskDeletion() {
        utils.setupTasksForTesting()

        let taskList = application.collectionViews.element(boundBy: 0)
        let editButton = application.buttons[Identifiers.editButton]
        editButton.tap()

        let taskCell = taskList.cells.element(boundBy: 0)
        let deleteIconButton = taskCell.images[Identifiers.deleteButtonIcon]
        deleteIconButton.tap()

        application.buttons["Done"].tap()

        utils.assertElementExists(taskCell, exists: true)
    }

}

extension TaskDeletionTests {
    private func tapDeleteButton() {
        let deleteButton = application.buttons[Identifiers.deleteButton]
        utils.assertElementExists(deleteButton, exists: true)
        deleteButton.tap()
    }
}
