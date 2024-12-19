//
//  XCTestCase+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//

import XCTest

extension XCTestCase {
    func setupUITest() -> XCUIApplication {
        continueAfterFailure = false

        let application = XCUIApplication()
        application.launchArguments += ["-AppleLanguages", "(en)", "-AppleLocale", "en_US", "testing"]
        application.launch()

        return application
    }

    func teardownUITest(_ application: XCUIApplication) {
        application.terminate()
    }
}
