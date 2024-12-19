//
//  TaskEditingTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

// タスク編集に関するテスト
final class TaskEditingTests: XCTestCase {
    private var application: XCUIApplication!
    private var utils: UITestUtils!

    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)

        utils.setupTasksAllInformation()
        utils.tapTaskCell()
    }

    override func tearDown() {
        teardownUITest(application)
        utils = nil
        application = nil
        super.tearDown()
    }

    /// タイトルを編集できる
    @MainActor
    func testEditTaskTitle() {
        let title = "Task1"

        utils.assertStaticText(
            identifier: Identifiers.titleLabel,
            value: title
        )

        tapTaskEditButton()

        let editTitle = "Renamed Task"
        editTaskTextField(identifier: Identifiers.titleLabel, editTitle)

        utils.tapTaskCell()

        utils.assertStaticText(
            identifier: Identifiers.titleLabel,
            value: editTitle
        )
    }

    /// コメントを編集できる
    @MainActor
    func testEditTaskComment() {
        let comment = "comment"

        utils.assertStaticText(
            identifier: Identifiers.commentLabel,
            value: comment)

        utils.assertStaticText(identifier:
                                Identifiers.statusLabel,
                               value: MockTaskStatus.inProgress.title)

        tapTaskEditButton()

        let editComment = "Edited Comment"
        editTaskTextField( identifier: Identifiers.commentField,
                           editComment
        )

        utils.tapTaskCell()

        utils.assertStaticText(identifier: Identifiers.commentLabel, value: editComment)
    }

    /// URLを追加・編集できる
    @MainActor
    func testEditTaskURL() {
        let url = "https://www.google.co.jp/"

        utils.assertStaticText(identifier:
                                Identifiers.urlLabel, value: url)

        tapTaskEditButton()
        let editURL = "https://github.com/"
        editTaskTextField(identifier: Identifiers.urlLabel, editURL)

        utils.tapTaskCell()

        utils.assertStaticText(
            identifier: Identifiers.urlLabel,
            value: editURL
        )
    }

    /// ステータスを変更できる
    @MainActor
    func testChangeTaskStatus() {
        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTaskStatus.inProgress.title
        )
        tapTaskEditButton()

        
       
        utils.tapStatusPicker(MockTaskStatus.inProgress)
        
        let completedButton = application.buttons[MockTaskStatus.completed.title]
        completedButton.tap()

        utils.tapSaveButton()

        utils.tapTaskCell()

        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTaskStatus.completed.title
        )
    }

    /// 期限を変更できる
    @MainActor
    func testChangeTaskDueDate() {
        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "1/2/2040, 3:31 PM"
        )

        tapTaskEditButton()
        
        utils.pickDate(DateComponents(year: 2045, month: 12, day: 25, hour: 6, minute: 56))
        utils.tapSaveButton()

        utils.tapTaskCell()

        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "12/25/2045, 6:56 AM"
        )
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// 空白のみのタイトルに編集しようとした場合、保存ボタンが無効になる
    @MainActor
    func testCannotEditTaskWithEmptyTitle() {
        tapTaskEditButton()
        let textField = application.textFields[Identifiers.titleLabel]
        textField.tap()

        textField.doubleTap()

        textField.typeText("\u{8}")
        textField.typeText("")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled:false)
    }
}

extension TaskEditingTests {

    private func tapTaskEditButton() {
        utils.tapTaskCell()
        utils.tapEditButton()
    }

    private func editTaskTextField(identifier: String, _ text: String) {
        let textField = application.textFields[identifier]
        textField.tap()
        // テキスト全選択
        textField.doubleTap()
        // テキスト削除
        textField.typeText("\u{8}")
        textField.typeText(text)

        utils.tapSaveButton()
    }
}
