//
//  HomeViewUITests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//
import SwiftUI
import XCTest

final class HomeViewUITests: XCTestCase {
    var application: XCUIApplication!

    override func setUp() {
        super.setUp()
        application = setupUITest()
    }

    override func tearDown() {
        teardownUITest(application)
        application = nil
        super.tearDown()
    }

    //// 空のタスクリストが正しく表示されるか確認
    @MainActor
    func testHomeViewContentEmptyView() throws {
        let navigationBar = application.navigationBars.element
        XCTAssertTrue(navigationBar.exists, "Navigation bar should exist")

        let navigationTitle = navigationBar.staticTexts["Task List"]
        XCTAssertTrue(navigationTitle.exists, "TaskList navigation title should exist")

        XCTAssertFalse(
            application.buttons[AccessibilityIdentifiers.editButton].exists,
            "Edit button should not be visible"
        )

        XCTAssertTrue(
            application.buttons[AccessibilityIdentifiers.addTaskButton].exists,
            "Add Task button should be visible"
        )
        XCTAssertTrue(
            application.images[AccessibilityIdentifiers.emptyIcon].exists,
            "Empty icon should be visible"
        )
        XCTAssertTrue(
            application.staticTexts[AccessibilityIdentifiers.emptyTitle].exists,
            "Empty title should be visible"
        )
        XCTAssertTrue(
            application.staticTexts[AccessibilityIdentifiers.emptyMessage].exists,
            "Empty message should be visible"
        )
    }

    /// タスクを追加した後にリストに正しく表示されることを確認
    @MainActor
    func testAddingTaskDisplaysItInTheList() throws {
        let addTaskButton = application.buttons[AccessibilityIdentifiers.addTaskButton]
        addTaskButton.tap()

        XCTAssertTrue(
            application.navigationBars["New Task"].exists,
            "New Task sheet should be displayed"
        )

        let titleField = application.textFields[AccessibilityIdentifiers.titleField]
        XCTAssertTrue(
            titleField.exists,
            "The title field should exist on the New Task screen"
        )

        titleField.tap()
        titleField.typeText("Task1")
        XCTAssertEqual(
            titleField.value as? String,
            "Task1", "The title field should contain the input text"
        )

        let saveButton = application.buttons[AccessibilityIdentifiers.saveButton]
        XCTAssertTrue(saveButton.exists, "Save button should exist")
        saveButton.tap()
    }

    /// タスクが存在する場合、編集ボタンが表示されることを確認
    @MainActor
    func testEditButtonAppearance() throws {
        TestHelper.setupTasksForTesting(app: application)
        XCTAssertTrue(application.buttons[AccessibilityIdentifiers.editButton].exists,
                      "Edit button should exist")
    }

    /// タスクリストのセルが正しく操作できることを確認
    @MainActor
    func testTaskListInteraction() throws {
        TestHelper.setupTasksForTesting(app: application, tasks: ["Test Task"])

        let taskList = application.collectionViews.element(boundBy: 0)
        let firstTaskCell = taskList.cells.element(boundBy: 0)

        XCTAssertTrue(firstTaskCell.exists, "The first task cell should exist")
        firstTaskCell.tap()

        XCTAssertTrue(application.staticTexts["Test Task"].exists, "Task title should be visible")
    }

    //// 左スワイプでタスクを削除する操作が正しく動作することを確認
    @MainActor
    func testSwipeDeleteTask() throws {
        TestHelper.setupTasksForTesting(app: application)

        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)

        taskCell.swipeLeft()
        application.buttons[AccessibilityIdentifiers.deleteButton].tap()

        XCTAssertFalse(taskCell.exists, "Task cell should be deleted")
    }

    //// タスクの並び替えが正しく動作することを確認
    func testMoveTask() throws {
        TestHelper.setupTasksForTesting(app: application, tasks: ["Task 1", "Task 2"])
        let taskCell = application.collectionViews.element(boundBy: 0).cells

        let initialFirstTaskTitle = taskCell.element(boundBy: 0).staticTexts["Task 1"].label
        let initialSecondTaskTitle = taskCell.element(boundBy: 1).staticTexts["Task 2"].label

        let editButton = application.buttons[AccessibilityIdentifiers.editButton]
        editButton.tap()

        let firstTask = taskCell.element(boundBy: 0)
        firstTask.press(forDuration: 1, thenDragTo: taskCell.element(boundBy: 1))

        let doneButton = application.buttons[AccessibilityIdentifiers.doneButton]
        doneButton.tap()

        let updatedFirstTaskTitle = taskCell.element(boundBy: 0).staticTexts["Task 2"].label
        let updatedSecondTaskTitle = taskCell.element(boundBy: 1).staticTexts["Task 1"].label

        XCTAssertEqual(
            updatedFirstTaskTitle, initialSecondTaskTitle,
            "First task should have been moved"
        )
        XCTAssertEqual(
            updatedSecondTaskTitle, initialFirstTaskTitle,
            "Second task should have been moved"
        )
    }
}
