//
//  TodoAdditionTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

/// Todo追加画面のテストケース
final class TodoAdditionTests: XCTestCase {

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

    /// 最小限の情報（タイトルのみ）でTodoが作成できることを確認する
    @MainActor
    func testCanAddTodoWithMinimalInformation() {
        utils.tapAddTodoButton()

        let title = "Todo1"
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: title
        )
        utils.tapSaveButton()

        utils.tapTodoCell()

        // Todoの詳細を確認
        utils.assertStaticText(identifier: Identifiers.titleLabel, value: title)
        utils.assertStaticText(
            identifier: Identifiers.statusLabel,
            value: MockTodoStatus.notStarted.title
        )
        utils.assertStaticText(identifier: Identifiers.commentLabel, value: nil)
        utils.assertStaticText(identifier: Identifiers.dueDateLabel, value: "None")
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// すべての情報を使ってTodoが作成できることを確認する
    @MainActor
    func testCanAddTodoWithCompleteInformation() {
        utils.setupTodosAllInformation()

        utils.tapTodoCell()

        // Todoの詳細を確認
        let title = "Todo1"
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
            value: MockTodoStatus.inProgress.title
        )
        utils.assertStaticText(
            identifier: Identifiers.dueDateLabel,
            value: "1/2/2040, 3:31 PM"
        )
        utils.assertDate(label: Identifiers.createdDateLabel)
    }

    /// タイトルが空の場合、Todoを保存できないことを確認する
    @MainActor
    func testCannotSaveTodoWithEmptyTitle() {
        utils.tapAddTodoButton()
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: ""
        )

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled: false)
    }

    /// タイトルが改行の場合、Todoを保存できないことを確認する
    @MainActor
    func testCannotSaveTodoWithNewlinesTitle() {
        utils.tapAddTodoButton()
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: "\n"
        )
        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled: false)
    }

    /// 過去の日付の期限設定した場合、Todoを保存できないことを確認する
    @MainActor
    func testCannotSavePastDueDates() {
        utils.tapAddTodoButton()
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: "Todo1"
        )

        utils.pickDate(DateComponents(year: 2020, month: 1, day: 2))
        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled: false)
    }

    /// URLが無効の場合、Todoを保存できないことを確認する
    @MainActor
    func testCannotSaveInvalidURL() {
        utils.tapAddTodoButton()
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: "Todo1"
        )

        utils.enterTextField(
            identifier: Identifiers.urlLabel,
            text: "invalid"
        )

        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementIsEnabled(saveButton, isEnabled: false)
    }

    /// 長いタイトルでTodoが作成できることを確認する
    @MainActor
    func testCanAddTodoWithMaximumLengthTitle() {
        utils.tapAddTodoButton()
        let longTitle = String(repeating: "1", count: 128)
        utils.enterTextField(
            identifier: Identifiers.titleLabel,
            text: longTitle
        )
        utils.tapSaveButton()

        utils.tapTodoCell()

        utils.assertStaticText(identifier: "Title", value: longTitle)
    }
}
