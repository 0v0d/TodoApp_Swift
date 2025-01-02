//
//  NavigationAndUITests+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/15.
//
import XCTest

extension NavigationAndUITests {
    /// Todoフォームビューの各要素が正しく表示され、機能するかを検証します
    ///
    /// - Note:
    /// - このメソッドでは、Todo追加/編集フォームに含まれる全ての主要なUI要素が正しく存在し、
    /// - それぞれが期待通りに動作することを確認します。
    func verifyTodoFormView() {
        // "Save" ボタンが存在するか確認
        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementExists(saveButton, exists: true)

        // "Cancel" ボタンが存在するか確認
        let cancelButton = application.buttons[Identifiers.cancelButton]
        utils.assertElementExists(cancelButton, exists: true)

        // タイトルフィールド（ラベルと入力フィールド）の検証
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.titleLabel,
            requiredLabel: "*", // 必須マークを確認
            textFieldLabel: Identifiers.titleLabel
        )

        // コメントフィールド（ラベルと入力フィールド）の検証
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.commentLabel,
            textFieldLabel: Identifiers.commentField
        )

        // URLフィールド（ラベルと入力フィールド）の検証
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.urlLabel,
            textFieldLabel: Identifiers.urlLabel
        )

        // ステータスラベルが存在するか確認
        utils.assertStaticText(identifier: Identifiers.statusLabel, value: nil)

        // ステータスピッカーのテスト："Not Started" 状態を選択
        utils.tapStatusPicker(.notStarted)

        // ピッカーが正しく表示されているか確認（2つのピッカーが存在することを確認）
        XCTAssertEqual(application.pickers.count, 2, "Picker should exist")

        // Due Date（期限）のピッカーを検証
        verifyDueDatePicker()

        // 時刻のピッカーを検証
        verifyTimePicker()
    }

    /// Due Date（期限）ピッカーの正確性を検証します
    ///
    /// - Note:現在の日付に基づいて、ピッカーの値が正しく表示されることを確認します。
    private func verifyDueDatePicker() {
        // Due Date ラベルが存在するか確認
        utils.assertStaticText(identifier: Identifiers.dueDateLabel, value: nil)

        let date = Date()
        let locale = Locale(identifier: "en_US")

        // 現在の月を取得し、ピッカーの値と比較
        let monthName = date.formatted(.dateTime.month(.wide).locale(locale))
        XCTAssertEqual(
            application.pickerWheels.element(boundBy: 0).value as? String,
            monthName,
            "Month should match"
        )

        // 現在の日を取得し、ピッカーの値と比較
        let day = date.formatted(.dateTime.day().locale(locale))
        XCTAssertEqual(
            application.pickerWheels.element(boundBy: 1).value as? String,
            day,
            "Day should match"
        )
    }

    /// 時刻ピッカーの正確性を検証します
    ///
    /// - Note:時刻選択用のピッカーの各ホイールが正しく表示され、期待通りに存在することを確認します。
    private func verifyTimePicker() {
        // 時刻ラベルが存在するか確認
        utils.assertStaticText(identifier: "Time", value: nil)

        // ピッカーの各ホイールが存在することを確認
        let timePickerWheels = [2, 3, 4]
        timePickerWheels.forEach { index in
            XCTAssertTrue(
                application.pickerWheels.element(boundBy: index).exists,
                "Time picker wheel at index \(index) should exist"
            )
        }
    }

    /// 静的ラベルとテキストフィールドの存在と関連性を検証します
    ///
    /// - Parameters:
    ///   - staticLabel: 検証するラベルの識別子
    ///   - requiredLabel: 必須ラベルの識別子（オプション）
    ///   - textFieldLabel: テキストフィールドの識別子
    /// - Note: 静的ラベル、必須マーク、そしてテキストフィールドが正しく配置されていることを確認します。
    private func verifyStaticTextAndTextField(
        staticLabel: String,
        requiredLabel: String? = nil,
        textFieldLabel: String
    ) {
        // 静的ラベルが存在するか確認
        utils.assertStaticText(identifier: staticLabel, value: nil)

        // 必須ラベルが存在する場合、それを確認
        if let requiredLabel = requiredLabel {
            utils.assertStaticText(identifier: requiredLabel, value: nil)
        }

        // テキストフィールドが存在するか確認
        let textField = application.textFields[textFieldLabel]
        utils.assertElementExists(textField, exists: true)
    }
}
