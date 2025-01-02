//
//  TodoSetupUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

/// Todoのセットアップを行うためのユーティリティクラス
///
/// テスト環境で必要なTodoを効率的にセットアップするメソッドを提供します。
/// Todoの追加、詳細情報の入力、日付やステータスの選択といった操作を抽象化しています。
final class TodoSetupUtils {

    private let app: XCUIApplication

    /// 初期化処理
    ///
    /// - Parameter app: テスト対象のアプリケーションインスタンス
    init(app: XCUIApplication) {
        self.app = app
    }

    /// テスト用のTodoをセットアップします
    ///
    /// - Parameter todos: セットアップするTodoのタイトルの配列
    /// TodoタイトルごとにTodoを追加し、保存ボタンをタップします。
    func setupTodosForTesting(todos: [String]) {
        todos.forEach { todo in
            app.buttons[Identifiers.addTodoButton].tap()
            let titleField = app.textFields[Identifiers.titleLabel]
            titleField.tap()
            titleField.typeText(todo)
            app.buttons[Identifiers.saveButton].tap()
        }
    }

    /// すべての情報を含むTodoをセットアップします
    ///
    /// - Note: Todoのタイトル、コメント、URL、ステータス、期限（Due Date）を含む詳細を設定します。
    func setupTodosAllInformation() {
        app.buttons[Identifiers.addTodoButton].tap()
        enterTodoDetails(
            title: "Todo1",
            comment: "comment",
            url: "https://www.google.co.jp/",
            status: MockTodoStatus.inProgress,
            dueDate: DateComponents(year: 2040, month: 1, day: 2, hour: 15, minute: 31)
        )
        app.buttons[Identifiers.saveButton].tap()
    }

    /// Todoの詳細情報を入力します
    ///
    /// - Parameters:
    ///   - title: Todoのタイトル
    ///   - comment: Todoのコメント
    ///   - url: Todoに関連するURL
    ///   - status: Todoのステータス
    ///   - dueDate: Todoの期限（DateComponents形式）
    private func enterTodoDetails(
        title: String,
        comment: String,
        url: String,
        status: MockTodoStatus,
        dueDate: DateComponents
    ) {
        enterText(field: Identifiers.titleLabel, text: title)
        enterText(field: Identifiers.commentField, text: comment)
        enterText(field: Identifiers.urlLabel, text: url)

        selectStatus(selectStatus: status)
        pickDate(dueDate)
    }

    /// テキストフィールドにテキストを入力します
    ///
    /// - Parameters:
    ///   - field: テキストフィールドの識別子
    ///   - text: 入力するテキスト
    private func enterText(field: String, text: String) {
        let textField = app.textFields[field]
        textField.tap()
        textField.typeText(text)
    }

    /// 日付選択用のピッカーを設定します
    ///
    /// - Parameter dateComponents: 設定する日付（DateComponents形式）
    func pickDate(_ dateComponents: DateComponents) {
        let monthNames = ["January", "February", "March", "April", "May", "June",
                          "July", "August", "September", "October", "November", "December"]

        // 各ピッカーの値を計算するクロージャ
        let pickerValues: [DatePickerComponent: String?] = [
            .month: dateComponents.month.flatMap { month in
                // 1〜12の範囲内の場合に月名を取得
                (1...12).contains(month) ? monthNames[month - 1] : nil
            },
            .day: dateComponents.day.map { "\($0)" },
            .year: dateComponents.year.map { "\($0)" },
            .hour: dateComponents.hour.map {
                let hour12 = $0 > 12 ? $0 - 12 : $0
                return "\($0 == 0 ? 12 : hour12)"
            },
            .ampm: dateComponents.hour.map { $0 >= 12 ? "PM" : "AM" },
            .minute: dateComponents.minute.map { "\($0)" }
        ]

        // ピッカーを調整
        pickerValues.forEach { component, value in
            if let value = value {
                app.pickerWheels.element(boundBy: component.rawValue).adjust(toPickerWheelValue: value)
            }
        }
    }

    /// ステータスを選択します
    ///
    /// - Parameter selectStatus: 設定するステータス
    private func selectStatus(selectStatus: MockTodoStatus) {
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + MockTodoStatus.notStarted.title]
        XCTAssertTrue(statusButton.exists, "Status button should exist")
        statusButton.tap()

        let selectStatusButton = app.buttons[selectStatus.title]
        XCTAssertTrue(selectStatusButton.exists, "Selected status button should exist")
        selectStatusButton.tap()
    }
}
