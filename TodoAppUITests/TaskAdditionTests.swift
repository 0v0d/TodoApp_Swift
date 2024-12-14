//
//  TaskAdditionTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

final class TaskAdditionTests: XCTestCase {
    private var application: XCUIApplication!
    private var utils: UITestUtils!

    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)

        let addTaskButton = application.buttons[AccessibilityIdentifiers.addTaskButton]
        addTaskButton.tap()
    }

    override func tearDown() {
        teardownTestEnvironment()
        super.tearDown()
    }

    private func teardownTestEnvironment() {
        teardownUITest(application)
        application = nil
    }

    /// 最小限の情報（タイトルのみ）でタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithMinimalInformation() {
        AddTaskWithTitle("Task1")

        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)
        XCTAssertTrue(taskCell.exists, "タスクのセルが作成されるべきです")

        taskCell.tap()

        // タスクの詳細を確認
        utils.assertStaticText(label: "Title", value: "Task1")
        utils.assertStaticText(label: "Status", value: "Not Started")
        utils.assertStaticText(label: "Comments", value: nil)
        utils.assertStaticText(label: "Due Date", value: "None")
        utils.assertDate(label: "Created Date")
    }

    /// すべての情報を使ってタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithCompleteInformation() {
        let titleField = application.textFields[AccessibilityIdentifiers.titleField]
        let commentField = application.textFields[AccessibilityIdentifiers.commentField]
        let urlField = application.textFields[AccessibilityIdentifiers.urlField]
        let statusButton = application.buttons[AccessibilityIdentifiers.statusPicker]
        let saveButton = application.buttons[AccessibilityIdentifiers.saveButton]

        titleField.tap()
        titleField.typeText("Task1")

        commentField.tap()
        commentField.typeText("comment")

        urlField.tap()
        urlField.typeText("https://www.google.co.jp/")

        statusButton.tap()
        let inProgressButton = application.buttons["In Progress"]
        inProgressButton.tap()

        // 期限日を設定
        application.pickerWheels.element(boundBy: 0).adjust(toPickerWheelValue: "January")
        application.pickerWheels.element(boundBy: 1).adjust(toPickerWheelValue: "1")
        application.pickerWheels.element(boundBy: 2).adjust(toPickerWheelValue: "2040")
        application.pickerWheels.element(boundBy: 3).adjust(toPickerWheelValue: "12")
        application.pickerWheels.element(boundBy: 4).adjust(toPickerWheelValue: "00")

        saveButton.tap()

        // 検証
        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)
        taskCell.tap()

        // タスクの詳細を確認
        utils.assertStaticText(label: "Title", value: "Task1")
        utils.assertStaticText(label: "Comments", value: "comment")
        utils.assertStaticText(label: "URL", value: "https://www.google.co.jp/")
        utils.assertStaticText(label: "Status", value: "In Progress")
        utils.assertStaticText(label: "Due Date", value: "1/1/2040, 12:00 AM")

        utils.assertDate(label: "Created Date")
    }

    /// タイトルが空の場合、タスクを保存できないことを確認する
    @MainActor
    func testCannotSaveTaskWithEmptyTitle() {
        let titleField = application.textFields[AccessibilityIdentifiers.titleField]
        titleField.tap()
        titleField.typeText("")

        utils.assertButton(label: AccessibilityIdentifiers.saveButton)
        let saveButton = application.buttons[AccessibilityIdentifiers.saveButton]
        XCTAssertFalse(saveButton.isEnabled, "The save button should be disabled")
    }

    /// 最大長のタイトルでタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithMaximumLengthTitle() {
        // 準備
        let longTitle = String(repeating: "1", count: 128)

        AddTaskWithTitle(longTitle)

        // 検証
        let taskList = application.collectionViews.element(boundBy: 0)
        let taskCell = taskList.cells.element(boundBy: 0)
        XCTAssertTrue(taskCell.exists, "タスクのセルが作成されるべきです")

        taskCell.tap()
        utils.assertStaticText(label: "Title", value: longTitle)
    }

    private func addTaskWithTitle(_ title: String) {
        let titleField = application.textFields[AccessibilityIdentifiers.titleField]
        titleField.tap()
        titleField.typeText(title)

        let saveButton = application.buttons[AccessibilityIdentifiers.saveButton]
        saveButton.tap()
    }
}
