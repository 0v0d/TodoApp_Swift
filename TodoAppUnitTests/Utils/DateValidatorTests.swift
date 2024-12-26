//
//  DateValidatorTests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/02.
//
import XCTest
@testable import TodoApp

/// `DateValidator` の動作を検証するテストクラス
///
/// このクラスでは、`DateValidator` のメソッド `isTimeValid` と `isDueDateValid` の動作をテストします
/// テストは、日付が `nil` の場合、過去の日付、現在の日付、未来の日付に対する振る舞いをカバーしています
final class DateValidatorTests: XCTestCase {

    /// テスト対象の `DateValidator` インスタンス
    private let dateValidator = DateValidator()

    /// `isTimeValid` が `nil` の場合に `true` を返すことを検証
    ///
    /// - 期待結果: 入力が `nil` の場合は `true` を返す
    func testIsTimeValidWhenDateIsNil() {
        XCTAssertTrue(dateValidator.isTimeValid(nil))
    }

    /// `isTimeValid` が過去の日付に対して `false` を返すことを検証
    ///
    /// - 期待結果: 過去の日付を渡した場合は `false` を返す
    func testIsTimeValidWhenDateIsInPast() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        XCTAssertFalse(dateValidator.isTimeValid(pastDate))
    }

    /// `isTimeValid` が現在の日付に対して `true` を返すことを検証
    ///
    /// - 期待結果: 現在の日時を渡した場合は `true` を返す
    func testIsTimeValidWhenDateIsNow() {
        // 時刻比較の微妙な誤差を回避するため、現在時刻より少し未来の時刻を使用
        let now = Date().addingTimeInterval(0.0001)
        XCTAssertTrue(dateValidator.isTimeValid(now))
    }

    /// `isTimeValid` が未来の日付に対して `true` を返すことを検証
    ///
    /// - 期待結果: 未来の日付を渡した場合は `true` を返す
    func testIsTimeValidWhenDateIsInFuture() {
        let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        XCTAssertTrue(dateValidator.isTimeValid(futureDate))
    }

    /// `isDueDateValid` が `nil` の場合に `true` を返すことを検証
    ///
    /// - 期待結果: 入力が `nil` の場合は `true` を返す
    func testIsDueDateValidWhenDateIsNil() {
        XCTAssertTrue(dateValidator.isDueDateValid(nil))
    }

    /// `isDueDateValid` が過去の日付に対して `false` を返すことを検証
    ///
    /// - 期待結果: 今日より前の日付を渡した場合は `false` を返す
    func testIsDueDateValidWhenDateIsBeforeToday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        XCTAssertFalse(dateValidator.isDueDateValid(yesterday))
    }

    /// `isDueDateValid` が今日の日付に対して `true` を返すことを検証
    ///
    /// - 期待結果: 今日の日付を渡した場合は `true` を返す
    func testIsDueDateValidWhenDateIsToday() {
        let today = Calendar.current.startOfDay(for: Date())
        XCTAssertTrue(dateValidator.isDueDateValid(today))
    }

    /// `isDueDateValid` が未来の日付に対して `true` を返すことを検証
    ///
    /// - 期待結果: 今日より後の日付を渡した場合は `true` を返す
    func testIsDueDateValidWhenDateIsAfterToday() {
        let tomorrow = Calendar.current.date(
            byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))
        XCTAssertTrue(dateValidator.isDueDateValid(tomorrow))
    }
}
