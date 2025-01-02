//
//  XCTestCase+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//

import XCTest

extension XCTestCase {
    /// UIテストのセットアップ処理
    ///
    /// - Returns: テスト対象のアプリケーション
    ///
    /// - Note:
    ///  - `launchArguments`で言語設定を英語に統一します
    ///  - `testing`の有無で`TodoRepository`のテストモードを切り替えます
    ///  - テスト時にはデータが永続化されず、テスト終了後にデータが破棄されます
    func setupUITest() -> XCUIApplication {
        continueAfterFailure = false

        let application = XCUIApplication()
        application.launchArguments += ["-AppleLanguages", "(en)", "-AppleLocale", "en_US", "testing"]
        application.launch()

        return application
    }

    /// UIテストのクリーンアップ処理
    ///
    /// - Parameter application: テスト対象のアプリケーション
    ///
    /// - Note: アプリケーションを終了します
    func teardownUITest(_ application: XCUIApplication) {
        application.terminate()
    }
}
