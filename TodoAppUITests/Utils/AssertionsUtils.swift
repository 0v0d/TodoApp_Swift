//
//  AssertionsUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

final class AssertionsUtils {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    func assertStaticText(identifier: String, value: String?, timeout: TimeInterval = 2) {
        let labelElement = app.staticTexts[identifier]
        XCTAssertTrue(labelElement.waitForExistence(timeout: timeout), "\(identifier) label should exist")

        if let value = value {
            let valueElement = app.staticTexts[value]
            XCTAssertTrue(valueElement.waitForExistence(timeout: timeout), "\(identifier) value '\(value)' should exist")
        }
    }

    func assertElementExists(_ element: XCUIElement, exists: Bool, timeout: TimeInterval = 2) {
        let actualExists = element.waitForExistence(timeout: timeout)
        XCTAssertEqual(actualExists, exists, "\(element.label) existence should be \(exists)")
    }
    
    func assertElementIsEnabled(_ element: XCUIElement, isEnabled: Bool) {
        XCTAssertEqual(element.isEnabled, isEnabled,"\(element.label) existence should be \(isEnabled)")
    }

    func assertDate(label: String, withinSeconds: TimeInterval = 60) {
        assertStaticText(identifier : label, value: nil)

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
