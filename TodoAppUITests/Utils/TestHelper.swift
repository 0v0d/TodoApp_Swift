//
//  TestHelper.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//

import XCTest

struct TestHelper {
    static func setupTasksForTesting(app: XCUIApplication, tasks: [String] = ["test"]) {
        tasks.forEach { task in
            let addTaskButton = app.buttons[AccessibilityIdentifiers.addTaskButton]
            addTaskButton.tap()

            let titleField = app.textFields[AccessibilityIdentifiers.titleField]
            titleField.tap()
            titleField.typeText(task)

            let commentField = app.textFields[AccessibilityIdentifiers.commentField]
            commentField.tap()
            commentField.typeText("comment")

            let saveButton = app.buttons[AccessibilityIdentifiers.saveButton]
            saveButton.tap()
        }
    }

    static func tapFirstTaskInList(app: XCUIApplication, tasks: [String] = ["test"]) {
        setupTasksForTesting(app: app, tasks: tasks)

        let taskList = app.collectionViews.element(boundBy: 0)
        let firstTaskCell = taskList.cells.element(boundBy: 0)
        XCTAssertTrue(firstTaskCell.exists, "The first task cell should exist")
        firstTaskCell.tap()
    }

}
