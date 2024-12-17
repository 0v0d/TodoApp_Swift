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
    
    func setupTasksForTesting(tasks: [String] = ["test"]) {
        tasks.forEach { task in
            tapAddTaskButton()
            
            enterTitle(task)
            tapSaveButton()
        }
    }
    
    func setupTasksAllInformation() {
       
        tapAddTaskButton()
        let title = "Task1"
        let comment = "comment"
        let url = "https://www.google.co.jp/"
        
        enterTitle(title)
        
        let commentField = app.textFields[Identifiers.commentField]
        commentField.tap()
        commentField.typeText(comment)
        
        let urlField = app.textFields[Identifiers.urlLabel]
        urlField.tap()
        urlField.typeText(url)
        
        let statusButtonTitle = Identifiers.statusLabel + ", "+MockTaskStatus.notStarted.title
        let statusButton = app.buttons[statusButtonTitle]
        statusButton.tap()
        
        let inProgressButton = app.buttons[MockTaskStatus.inProgress.title]
        inProgressButton.tap()
        
        // 期限日を設定
        pickWheels(boundBy: 0, value: "January")
        pickWheels(boundBy: 1, value: "2")
        pickWheels(boundBy: 2, value: "2040")
        pickWheels(boundBy: 3, value: "3")
        pickWheels(boundBy: 4, value: "31")
        pickWheels(boundBy: 5, value: "PM")
        
        
        tapSaveButton()
    }
    
    func assertStaticText(identifier: String, value: String?) {
        let labelElement = app.staticTexts[identifier]
        XCTAssertTrue(labelElement.exists, "\(identifier) label should exist")
        
        if let value = value {
            let valueElement = app.staticTexts[value]
            XCTAssertTrue(valueElement.exists, "\(identifier) value '\(value)' should exist")
        }
    }
    
    func assertElementExists(_ element: XCUIElement, exists: Bool) {
        if exists {
            XCTAssertTrue(element.exists, "\(element.label) should exist")
        } else {
            XCTAssertFalse(element.exists, "\(element.label) should not exist")
        }
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
    
    func verifySaveButton(saveButton: XCUIElement,expected: Bool) {
        if expected {
            XCTAssertTrue(saveButton.isEnabled, "Save button should be enabled")
        } else {
            XCTAssertFalse(saveButton.isEnabled, "Save button should be disabled")
        }
    }
    
    func pickWheels(boundBy: Int, value: String) {
        app.pickerWheels.element(boundBy: boundBy).adjust(
            toPickerWheelValue: value)
    }
    
    func tapTaskCell() {
        let taskList = app.collectionViews.element(boundBy: 0)
        assertElementExists(taskList, exists: true)
        
        let taskCell = taskList.cells.element(boundBy: 0)
        assertElementExists(taskCell, exists: true)
        taskCell.tap()
    }
    
    func tapEditButton() {
       let editButton = app.buttons[Identifiers.editButton]
        assertElementExists(editButton, exists: true)
       editButton.tap()
   }
    
    func tapSaveButton() {
        let saveButton = app.buttons[Identifiers.saveButton]
        verifySaveButton(saveButton: saveButton, expected: true)
        saveButton.tap()
    }
    
    func enterTitle(_ title: String) {
        let titleField = app.textFields[Identifiers.titleLabel]
        titleField.tap()
        titleField.typeText(title)
    }
    
    func getTaskStatusName(_ taskStatus: String) -> String {
        return Identifiers.statusLabel + ", " + taskStatus
    }

     func tapAddTaskButton() {
        let addTaskButton = app.buttons[Identifiers.addTaskButton]
        addTaskButton.tap()
    }
}
