//
//  UIInteractionUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

final class UIInteractionUtils {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func tapAddTaskButton() {
        app.buttons[Identifiers.addTaskButton].tap()
    }
    
    func tapSaveButton() {
        let saveButton = app.buttons[Identifiers.saveButton]
        XCTAssertTrue(saveButton.isEnabled, "Save button should be enabled")
        saveButton.tap()
    }
    
    func tapEditButton() {
        let editButton = app.buttons[Identifiers.editButton]
        XCTAssertTrue(editButton.exists, "Edit button should exist")
        
        editButton.tap()
    }
    
    func tapTaskCell() {
        let taskList = app.collectionViews.element(boundBy: 0)
        XCTAssertTrue(taskList.exists, "Task list should exist")
        let taskCell = taskList.cells.element(boundBy: 0)
        XCTAssertTrue(taskCell.exists, "Task cell should exist")
        taskCell.tap()
    }
    
    func enterTextField(identifier: String, text: String) {
        let textField = app.textFields[identifier]
        textField.tap()
        textField.typeText(text)
    }
    
    func tapStatusPicker(currentStatus: MockTaskStatus) {
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + currentStatus.title]
        XCTAssertTrue(statusButton.exists)
        statusButton.tap()
    }
}
