//
//  UITestUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//
import XCTest

final class UITestUtils {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func assertStaticText(label: String, value: String?) {
        let labelElement = app.staticTexts[label]
        XCTAssertTrue(labelElement.exists, "\(label) label should exist")

        if let value = value {
            let valueElement = app.staticTexts[value]
            XCTAssertTrue(valueElement.exists, "\(label) value '\(value)' should exist")
        }
    }

    func assertButton(label: String) {
        let labelElement = app.buttons[label]
        XCTAssertTrue(labelElement.exists, "\(label) label should exist")
    }

    func assertTextField(label: String) {
        let textFieldElement = app.textFields[label]
        XCTAssertTrue(textFieldElement.exists, "\(label) text field should exist")
    }

    func assertPicker(label: String) {
        let labelElement = app.datePickers[label]
        XCTAssertTrue(labelElement.exists, "\(label) label should exist")
    }

    func assertDate(label: String, withinSeconds: TimeInterval = 60) {
        let labelElement = app.staticTexts[label]
        XCTAssertTrue(labelElement.exists, "\(label) label should exist")

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
