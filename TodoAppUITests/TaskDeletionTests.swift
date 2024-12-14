//
//  TaskDeletionTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

/// タスク削除に関するテスト
final class TaskDeletionTests: XCTestCase {
    var application: XCUIApplication!
    var utils: UITestUtils!
    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)
    }

    override func tearDown() {
        teardownUITest(application)
        application = nil
        super.tearDown()
    }

    /// タスクを削除する操作が正しく動作することを確認
    @MainActor
    func testDeleteSingleTask() throws {
        TestHelper.setupTasksForTesting(app: application)

        let taskList = application.collectionViews.element(boundBy: 0)
        let editButton = application.buttons[AccessibilityIdentifiers.editButton]
        editButton.tap()

        let taskCell = taskList.cells.element(boundBy: 0)
        let deleteButton = taskCell.images[AccessibilityIdentifiers.deleteButtonIcon]

        XCTAssertTrue(deleteButton.exists, "Delete button should exist")
        deleteButton.tap()

        application.buttons[AccessibilityIdentifiers.deleteButton].tap()
        XCTAssertFalse(taskCell.exists, "Task cell should be deleted")
    }

    //// 左スワイプでタスクを削除する操作が正しく動作することを確認
    @MainActor
    func testSwipeDeleteSingleTask() throws {
        TestHelper.setupTasksForTesting(app: application)

        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)

        taskCell.swipeLeft()
        utils.assertButton(label: AccessibilityIdentifiers.deleteButton)
        application.buttons[AccessibilityIdentifiers.deleteButton].tap()

        XCTAssertFalse(taskCell.exists, "Task cell should be deleted")
    }

    /// 複数のタスクを同時に削除できる
    @MainActor
    func testDeleteMultipleTasks() {

    }

    /// 削除後にリストから消える
    @MainActor
    func testTaskDisappearsFromListAfterDeletion() {

    }

    /// 削除操作をキャンセルした場合の動作
    @MainActor
    func testCancelTaskDeletion() {

    }
}
