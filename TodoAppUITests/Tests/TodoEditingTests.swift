//
//  TodoEditingTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

// Todo編集に関するテスト
final class TodoEditingTests: XCTestCase {

    private var application: XCUIApplication!

    private var utils: UITestUtils!

    /// テスト実行前のセットアップ処理
    ///
    /// アプリケーションの起動や、テストで使用するユーティリティクラスの初期化を行います
    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)

        utils.setupTodosAllInformation()
        utils.tapTodoCell()
    }

    /// テスト実行後のクリーンアップ処理
    ///
    /// アプリケーションの終了や、関連リソースの解放を行います
    override func tearDown() {
        teardownUITest(application)
        utils = nil
        application = nil
        super.tearDown()
    }

    /// タイトルを編集できる
    @MainActor
    func testEditTodoTitle() {
        let title = "Todo1"

        utils.assertStaticText(
            identifier: Identifiers.titleLabel,
            value: title
        )

        tapTodoEditButton()

        let editTitle = "Renamed Todo"
        editTodoTextField(identifier: Identifiers.titleLabel, editTitle)

        utils.tapTodoCell()

        utils.assertStaticText(
            identifier: Identifiers.titleLabel,
            value: editTitle
        )
    }

    /// コメントを編集できる
    @MainActor
    func testEditTodoComment() {
        let comment = "comment"

        utils.assertStaticText(
            identifier: Identifiers.commentLabel,
            value: comment)

        utils.assertStaticText(identifier:
                                Identifiers.statusLabel,
                               value: MockTodoStatus.inProgress.title)

        tapTodoEditButton()

        let editComment = "Edited Comment"
        editTodoTextField( identifier: Identifiers.commentField,
                           editComment
        )

        utils.tapTodoCell()

        utils.assertStaticText(identifier: Identifiers.commentLabel, value: editComment)
    }

    /// URLを追加・編集できる
    @MainActor
    func testEditTodoURL() {
        let url = "https://www.google.co.jp/"

        utils.assertStaticText(identifier:
                                Identifiers.urlLabel, value: url)

        tapTodoEditButton()
        let editURL = "https://github.com/"
        editTodoTextField(identifier: Identifiers.urlLabel, editURL)

        utils.tapTodoCell()

        utils.assertStaticText(
            identifier: Identifiers.urlLabel,
            value: editURL
        )
    }

    /// ステータスを変更できる
    @MainActor
    func testChangeTodoStatus() {
        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTodoStatus.inProgress.title
        )
        tapTodoEditButton()

        utils.tapStatusPicker(MockTodoStatus.inProgress)

        let completedButton = application.buttons[MockTodoStatus.completed.title]
        completedButton.tap()

        utils.tapSaveButton()

        utils.tapTodoCell()

        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTodoStatus.completed.title
        )
    }

    /// 期限を変更できる
    @MainActor
    func testChangeTodoDueDate() {
        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "1/2/2040, 3:31 PM"
        )

        tapTodoEditButton()

        utils.pickDate(DateComponents(year: 2045, month: 12, day: 25, hour: 6, minute: 56))
        utils.tapSaveButton()

        utils.tapTodoCell()

        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "12/25/2045, 6:56 AM"
        )
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// 空白のみのタイトルに編集しようとした場合、保存ボタンが無効になる
    @MainActor
    func testCannotEditTodoWithEmptyTitle() {
        tapTodoEditButton()
        let textField = application.textFields[Identifiers.titleLabel]
        textField.tap()

        textField.doubleTap()

        textField.typeText("\u{8}")
        textField.typeText("")

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled: false)
    }
}

extension TodoEditingTests {

    /// Todo編集画面に遷移する
    private func tapTodoEditButton() {
        utils.tapTodoCell()
        utils.tapEditButton()
    }

    /// Todoのテキストフィールドを編集する
    ///
    /// - Parameters:
    ///  - identifier: テキストフィールドの識別子 (`String`型)
    ///  - text: 編集するテキスト (`String`型)
    private func editTodoTextField(identifier: String, _ text: String) {
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
