//
//  UIInteractionUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

/// UI操作を抽象化するためのユーティリティクラス
///
/// テストコード内で頻出する操作（ボタンタップ、テキスト入力など）を簡略化します。
final class UIInteractionUtils {
    private let app: XCUIApplication

    /// 初期化処理
    ///
    /// - Parameter app: テスト対象のアプリケーションインスタンス
    init(app: XCUIApplication) {
        self.app = app
    }

    /// タスク追加ボタンをタップします
    func tapAddTaskButton() {
        app.buttons[Identifiers.addTaskButton].tap()
    }

    /// "Save" ボタンをタップします
    func tapSaveButton() {
        let saveButton = app.buttons[Identifiers.saveButton]
        XCTAssertTrue(saveButton.isEnabled, "Save button should be enabled")
        saveButton.tap()
    }

    /// "Edit" ボタンをタップします
    func tapEditButton() {
        let editButton = app.buttons[Identifiers.editButton]
        XCTAssertTrue(editButton.exists, "Edit button should exist")

        editButton.tap()
    }

    /// タスクセルをタップします
    ///
    /// 最初のセルを選択し、タップ操作を実行します。
    func tapTaskCell() {
        let taskList = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(taskList.exists, "Task list should exist")
        let taskCell = taskList.cells.element(boundBy: 0)
        XCTAssertTrue(taskCell.exists, "Task cell should exist")
        taskCell.tap()
    }

    /// テキストフィールドに入力します
    ///
    /// - Parameters:
    ///  - identifier: テキストフィールドの識別子
    ///  - text: 入力するテキスト
    func enterTextField(identifier: String, text: String) {
        let textField = app.textFields[identifier]
        textField.tap()
        textField.typeText(text)
    }

    /// ステータスピッカーをタップします
    ///
    /// - Parameter currentStatus: 現在のステータス
    func tapStatusPicker(currentStatus: MockTaskStatus) {
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + currentStatus.title]
        XCTAssertTrue(statusButton.exists)
        statusButton.tap()
    }
}
