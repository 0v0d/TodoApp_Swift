//
//  NavigationAndUITests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/12.
//
import XCTest

/// アプリケーションのナビゲーションとUI操作に関するUIテストケース
///
/// - Note:
///  - このクラスでは、タスクリスト画面やタスク追加画面、編集画面間のナビゲーションが正しく動作するかを検証します
///  - 画面遷移が滑らかに行われるかをメトリクスを用いて測定します
final class NavigationAndUITests: XCTestCase {

    var application: XCUIApplication!

    var utils: UITestUtils!

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

    /// 空のビューからタスクを追加することでタスクリストが正しく表示されるかを検証するテスト
    @MainActor
    func testAddTaskToDisplayTaskList() {
        let navigationBar = application.navigationBars[Identifiers.taskListScreen]
        utils.assertElementExists(navigationBar, exists: true)

        let editButton = application.buttons[Identifiers.editButton]
        utils.assertElementExists(editButton, exists: false)

        let addTaskButton = application.buttons[Identifiers.addTaskButton]
        utils.assertElementExists(addTaskButton, exists: true)

        let emptyIcon = application.images[Identifiers.emptyIcon]
        utils.assertElementExists(emptyIcon, exists: true)

        utils.assertStaticText(identifier: Identifiers.emptyTitle, value: nil)
        utils.assertStaticText(identifier: Identifiers.emptyMessage, value: nil)

        utils.setupTasksForTesting()

        utils.tapTaskCell()
    }

    /// タスクリスト画面とタスク追加画面間の遷移を検証するテスト
    @MainActor
    func testNavigateBetweenTaskListAndAddScreen() {
        utils.setupTasksForTesting()
        utils.tapAddTaskButton()

        let navgationBar = application.navigationBars[Identifiers.addTaskScreen]
        utils.assertElementExists(navgationBar, exists: true)

        verifyTaskFormView()
    }

    /// タスクの詳細画面と編集画面間の遷移を検証するテスト
    @MainActor
    func testNavigateBetweenDetailAndEditScreen() {
        let editButton = application.buttons[Identifiers.editButton]
        utils.assertElementExists(editButton, exists: false)

        utils.setupTasksForTesting()

        utils.assertElementExists(editButton, exists: true)

        utils.tapTaskCell()

        // タスクの詳細を確認
        utils.assertStaticText(identifier: Identifiers.titleLabel, value: "test")

        // 編集画面に遷移
        application.buttons[Identifiers.editButton].tap()

        // 編集画面の要素を確認
        let navitionBar = application.navigationBars[Identifiers.editTaskScreen]
        utils.assertElementExists(navitionBar, exists: true)

        verifyTaskFormView()
    }

    /// タスク詳細画面へのナビゲーションが滑らかであることを確認するテスト
    @MainActor
    func testSmoothNavigationTaskDetailScreens() {
        // メトリクスの設定
        let navigationMetric = XCTOSSignpostMetric.navigationTransitionMetric

        // 各実行で新しいタスクを作成し、一貫性のあるテストを実施
        utils.setupTasksForTesting()

        measure(metrics: [navigationMetric]) {
            // 複数の遷移を連続して実行
            for _ in 0..<6 {

                utils.tapTaskCell()

                // 戻るボタンで一覧画面に戻る
                let backButton = application.navigationBars.buttons.element(boundBy: 0)
                backButton.tap()
            }
        }
    }

    /// タスク追加画面へのナビゲーションが滑らかであることを確認するテスト
    @MainActor
    func testSmoothNavigationAddTaskScreen() {
        // メトリクスの設定
        let navigationMetric = XCTOSSignpostMetric.navigationTransitionMetric
        measure(metrics: [navigationMetric]) {

            let addTaskButton = application.buttons[Identifiers.addTaskButton]
            utils.assertElementExists(addTaskButton, exists: true)
            addTaskButton.tap()

            let titleField = application.textFields[Identifiers.titleLabel]
            utils.assertElementExists(titleField, exists: true)

            titleField.tap()
            titleField.typeText("test")

            utils.tapSaveButton()
        }
    }
}
