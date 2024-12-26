//
//  UITestUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//
import XCTest

/// UIテストを支援するユーティリティクラス
///
/// `UITestUtils` は、タスクのセットアップ、UI要素の操作、およびアサーションを行うためのヘルパーメソッドを提供します。
/// このクラスは、`NavigationAndUITests`やその他のUIテストクラスで利用されます。
final class UITestUtils {
    private let taskSetup: TaskSetupUtils
    private let uiInteraction: UIInteractionUtils
    private let assertions: AssertionsUtils

    /// 初期化処理
    ///
    /// - Parameter app: テスト対象のアプリケーションインスタンス (`XCUIApplication`型)
    init(app: XCUIApplication) {
        taskSetup = TaskSetupUtils(app: app)
        uiInteraction = UIInteractionUtils(app: app)
        assertions = AssertionsUtils(app: app)
    }

    /// テスト用のタスクをセットアップします
    ///
    /// - Parameter tasks: 設定するタスク名の配列（デフォルトは ["test"]） (`[String]`型)
    func setupTasksForTesting(tasks: [String] = ["test"]) {
        taskSetup.setupTasksForTesting(tasks: tasks)
    }

    /// 情報を全て含むタスクをセットアップします
    func setupTasksAllInformation() {
        taskSetup.setupTasksAllInformation()
    }

    /// タスク追加ボタンをタップします
    func tapAddTaskButton() {
        uiInteraction.tapAddTaskButton()
    }

    /// "Save" ボタンをタップします
    func tapSaveButton() {
        uiInteraction.tapSaveButton()
    }

    /// 編集ボタンをタップします
    func tapEditButton() {
        uiInteraction.tapEditButton()
    }

    /// タスクセルをタップします
    func tapTaskCell() {
        uiInteraction.tapTaskCell()
    }

    /// 特定のテキストフィールドにテキストを入力します
    ///
    /// - Parameters:
    ///   - identifier: テキストフィールドの識別子 (`String`型)
    ///   - text: 入力するテキスト (`String`型)
    func enterTextField(identifier: String, text: String) {
        uiInteraction.enterTextField(identifier: identifier, text: text)
    }

    /// 静的テキスト要素の存在を検証します
    ///
    /// - Parameters:
    ///   - identifier: 検証する要素の識別子 (`String`型)
    ///   - value: 検証する値（オプション） (`String`型)
    func assertStaticText(identifier: String, value: String?) {
        assertions.assertStaticText(identifier: identifier, value: value)
    }

    /// 要素が存在するかを検証します
    ///
    /// - Parameters:
    ///   - element: 検証する要素 (`XCUIElement`型)
    ///   - exists: 存在を期待するかどうか (`Bool`型)
    func assertElementExists(_ element: XCUIElement, exists: Bool) {
        assertions.assertElementExists(element, exists: exists)
    }

    /// 要素が有効かを検証します
    ///
    /// - Parameters:
    ///  - element: 検証する要素 (`XCUIElement`型)
    ///  - isEnabled: 有効かの期待値 (`Bool`型)
    func assertElementIsEnabled(_ element: XCUIElement, isEnabled: Bool) {
        assertions.assertElementIsEnabled(element, isEnabled: isEnabled)
    }

    /// 日付が正しく表示されているかを検証します
    ///
    /// - Parameters:
    ///  - label: ラベル (`String`型)
    ///  - withinSeconds: 許容する秒数（デフォルトは60秒） (`TimeInterval`型)
    func assertDate(label: String, withinSeconds: TimeInterval = 60) {
        assertions.assertDate(label: label, withinSeconds: withinSeconds)
    }

    /// ステータスピッカーをタップします
    ///
    /// - Parameter date : 日付 (`DateComponents`型)
    func pickDate(_ date: DateComponents) {
        taskSetup.pickDate(date)
    }

    /// ステータスピッカーをタップします
    ///
    /// - Parameter currentStatus : 現在のステータス (`MockTaskStatus`型)
    func tapStatusPicker(_ currentStatus: MockTaskStatus) {
        uiInteraction.tapStatusPicker(currentStatus: currentStatus)
    }
}
