//
//  AssertionsUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

/// UI要素の状態を検証するためのユーティリティクラス
///
/// アサーションを抽象化することで、テストコードを簡潔かつ読みやすくします。
final class AssertionsUtils {

    private let app: XCUIApplication

    /// 初期化処理
    ///
    /// - Parameter app: テスト対象のアプリケーションインスタンス
    init(app: XCUIApplication) {
        self.app = app
    }

    /// 静的テキストが正しく存在し、期待される値を持つかを検証します
    ///
    /// - Parameters:
    ///   - identifier: ラベルの識別子
    ///   - value: 期待する値（オプション）
    ///   - timeout: 待機時間（デフォルトは2秒）
    func assertStaticText(
        identifier: String,
        value: String?,
        timeout: TimeInterval = 2
    ) {
        let labelElement = app.staticTexts[identifier]
        XCTAssertTrue(
            labelElement.waitForExistence(timeout: timeout),
            "\(identifier) label should exist"
        )

        if let value = value {
            let valueElement = app.staticTexts[value]
            XCTAssertTrue(
                valueElement.waitForExistence(timeout: timeout),
                "\(identifier) value '\(value)' should exist"
            )
        }
    }

    /// 要素が期待通りに存在するかを検証します
    ///
    /// - Parameters:
    ///   - element: 検証する要素
    ///   - exists: 存在の期待値
    ///   - timeout: 待機時間（デフォルトは2秒）
    func assertElementExists(_ element: XCUIElement, exists: Bool, timeout: TimeInterval = 2) {
        let actualExists = element.waitForExistence(timeout: timeout)
        XCTAssertEqual(actualExists, exists, "\(element.label) existence should be \(exists)")
    }

    /// 要素が有効かを検証します
    ///
    /// - Parameters:
    ///  - element: 検証する要素
    ///  - isEnabled: 有効かの期待値
    func assertElementIsEnabled(_ element: XCUIElement, isEnabled: Bool) {
        XCTAssertEqual(element.isEnabled, isEnabled, "\(element.label) existence should be \(isEnabled)")
    }

    /// 日付が正しく表示されているかを検証します
    ///
    /// - Parameters:
    ///  - label: ラベルの識別子
    ///  - withinSeconds: 期待する範囲（デフォルトは60秒）
    func assertDate(label: String, withinSeconds: TimeInterval = 60) {
        assertStaticText(identifier: label, value: nil)

        let now = Date()
        let calendar = Calendar.current

        let earliestDate = calendar.date(byAdding: .second, value: -Int(withinSeconds), to: now)!
        let latestDate = calendar.date(byAdding: .second, value: Int(withinSeconds), to: now)!

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "M/d/yyyy, h:mm a"

        let earliestString = dateFormatter.string(from: earliestDate)
        let latestString = dateFormatter.string(from: latestDate)

        let valueCell = app.cells.containing(.staticText, identifier: label).staticTexts.element(boundBy: 1)
        let displayedDate = valueCell.label

        XCTAssertTrue(
            displayedDate >= earliestString && displayedDate <= latestString,
            "\(label) value '\(displayedDate)' should be within the valid range (\(earliestString) - \(latestString))"
        )
    }
}
