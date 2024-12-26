//
//  TaskSetupUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

/// タスクのセットアップを行うためのユーティリティクラス
///
/// テスト環境で必要なタスクを効率的にセットアップするメソッドを提供します。
/// タスクの追加、詳細情報の入力、日付やステータスの選択といった操作を抽象化しています。
final class TaskSetupUtils {

    private let app: XCUIApplication

    /// 初期化処理
    ///
    /// - Parameter app: テスト対象のアプリケーションインスタンス
    init(app: XCUIApplication) {
        self.app = app
    }

    /// テスト用のタスクをセットアップします
    ///
    /// - Parameter tasks: セットアップするタスクのタイトルの配列
    /// タスクタイトルごとにタスクを追加し、保存ボタンをタップします。
    func setupTasksForTesting(tasks: [String]) {
        tasks.forEach { task in
            app.buttons[Identifiers.addTaskButton].tap()
            let titleField = app.textFields[Identifiers.titleLabel]
            titleField.tap()
            titleField.typeText(task)
            app.buttons[Identifiers.saveButton].tap()
        }
    }

    /// すべての情報を含むタスクをセットアップします
    ///
    /// - Note: タスクのタイトル、コメント、URL、ステータス、期限（Due Date）を含む詳細を設定します。
    func setupTasksAllInformation() {
        app.buttons[Identifiers.addTaskButton].tap()
        enterTaskDetails(
            title: "Task1",
            comment: "comment",
            url: "https://www.google.co.jp/",
            status: MockTaskStatus.inProgress,
            dueDate: DateComponents(year: 2040, month: 1, day: 2, hour: 15, minute: 31)
        )
        app.buttons[Identifiers.saveButton].tap()
    }

    /// タスクの詳細情報を入力します
    ///
    /// - Parameters:
    ///   - title: タスクのタイトル
    ///   - comment: タスクのコメント
    ///   - url: タスクに関連するURL
    ///   - status: タスクのステータス
    ///   - dueDate: タスクの期限（DateComponents形式）
    private func enterTaskDetails(
        title: String,
        comment: String,
        url: String,
        status: MockTaskStatus,
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
    private func selectStatus(selectStatus: MockTaskStatus) {
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + MockTaskStatus.notStarted.title]
        XCTAssertTrue(statusButton.exists, "Status button should exist")
        statusButton.tap()

        let selectStatusButton = app.buttons[selectStatus.title]
        XCTAssertTrue(selectStatusButton.exists, "Selected status button should exist")
        selectStatusButton.tap()
    }
}
