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
    }

    override func tearDown() {
        teardownUITest(application)
        application = nil
        super.tearDown()
    }

    /// 最小限の情報（タイトルのみ）でタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithMinimalInformation() {
        utils.tapAddTaskButton()

        let title = "Task1"
        utils.enterTitle(title)
        utils.tapSaveButton()

        utils.tapTaskCell()

        // タスクの詳細を確認
        utils.assertStaticText(identifier: Identifiers.titleLabel, value: title)
        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTaskStatus.notStarted.title
        )
        utils.assertStaticText(identifier: Identifiers.commentLabel, value: nil)
        utils.assertStaticText(identifier: Identifiers.dueDateLabel, value: "None")
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// すべての情報を使ってタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithCompleteInformation() {
        utils.setupTasksAllInformation()

        utils.tapTaskCell()

        // タスクの詳細を確認
        let title = "Task1"
        let comment = "comment"
        let url = "https://www.google.co.jp/"

        utils.assertStaticText(
            identifier: Identifiers.titleLabel,
            value: title
        )
        utils.assertStaticText(
            identifier: Identifiers.commentLabel,
            value: comment
        )
        utils.assertStaticText(
            identifier: Identifiers.urlLabel,
            value: url
        )
        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTaskStatus.inProgress.title
        )
        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "1/2/2040, 3:31 PM"
        )
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// タイトルが空の場合、タスクを保存できないことを確認する
    @MainActor
    func testCannotSaveTaskWithEmptyTitle() {
        utils.tapAddTaskButton()
        utils.enterTitle("")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.verifySaveButton(saveButton: saveButton, expected: false)
    }

    /// タイトルが改行の場合、タスクを保存できないことを確認する
    @MainActor
    func testCannotSaveTaskWithNewlinesTitle() {
        utils.tapAddTaskButton()
        utils.enterTitle("\n")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.verifySaveButton(saveButton: saveButton, expected: false)
    }

    /// 過去の日付の期限設定した場合、タスクを保存できないことを確認する
    @MainActor
    func testCannotSavePastDueDates() {
        utils.tapAddTaskButton()
        utils.enterTitle("Task1")

        utils.pickWheels(boundBy: .month, value: "January")
        utils.pickWheels(boundBy: .day, value: "1")
        utils.pickWheels(boundBy: .year, value: "2020")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.verifySaveButton(saveButton: saveButton, expected: false)
    }

    /// URLが無効の場合、タスクを保存できないことを確認する
    @MainActor
    func testCannotSaveInvalidURL() {
        utils.tapAddTaskButton()
        utils.enterTitle("Task1")

        let urlField = application.textFields[Identifiers.urlLabel]
        urlField.tap()
        urlField.typeText("invalid")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.verifySaveButton(saveButton: saveButton, expected: false)
    }

    /// 長いタイトルでタスクが作成できることを確認する
    @MainActor
    func testCanAddTaskWithMaximumLengthTitle() {
        utils.tapAddTaskButton()
        let longTitle = String(repeating: "1", count: 128)
        utils.enterTitle(longTitle)
        utils.tapSaveButton()

        utils.tapTaskCell()

        utils.assertStaticText(identifier: "Title", value: longTitle)
    }
}
