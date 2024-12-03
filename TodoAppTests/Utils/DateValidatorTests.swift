//
//  DateValidatorTests.swift
//  TodoAppTests
//
//  Created by 0v0 on 2024/12/02.
//
import XCTest
@testable import TodoApp

final class DateValidatorTests: XCTestCase {
    private let dateValidator = DateValidator()

    // IsTimeValidでnilの場合はtrueを返す
    func testIsTimeValidWhenDateIsNil() {
        XCTAssertTrue(dateValidator.isTimeValid(nil))
    }

    // IsTimeValidで過去の日付の場合はfalse
    func testIsTimeValidWhenDateIsInPast() {
        let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        XCTAssertFalse(dateValidator.isTimeValid(pastDate))
    }

    // IsTimeValidで現在の日付の場合はtrue
    func testIsTimeValidWhenDateIsNow() {
        // 時刻比較の微妙な問題を回避するために、0.0001秒後の時刻を取得
        let now = Date().addingTimeInterval(0.0001)
        XCTAssertTrue(dateValidator.isTimeValid(now))
    }

    // 未来の日付の場合はtrue
    func testIsTimeValidWhenDateIsInFuture() {
        let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        XCTAssertTrue(dateValidator.isTimeValid(futureDate))
    }

    // IsDueDateValidでnilの場合はtrueを返す
    func testIsDueDateValidWhenDateIsNil() {
        XCTAssertTrue(dateValidator.isDueDateValid(nil))
    }

    // IsDueDateValidで過去の日付の場合はfalse
    func testIsDueDateValidWhenDateIsBeforeToday() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
        XCTAssertFalse(dateValidator.isDueDateValid(yesterday))
    }

    // IsDueDateValid現在の日付の場合はtrue
    func testIsDueDateValidWhenDateIsToday() {
        let today = Calendar.current.startOfDay(for: Date())
        XCTAssertTrue(dateValidator.isDueDateValid(today))
    }

    // IsDueDateValidで未来の日付の場合はtrue
    func testIsDueDateValidWhenDateIsAfterToday() {
        let tomorrow = Calendar.current.date(
            byAdding: .day, value: 1, to: Calendar.current.startOfDay(for: Date()))
        XCTAssertTrue(dateValidator.isDueDateValid(tomorrow))
    }
}
