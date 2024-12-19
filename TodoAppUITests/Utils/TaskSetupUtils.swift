//
//  TaskSetupUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/18.
//
import XCTest

final class TaskSetupUtils {
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    func setupTasksForTesting(tasks: [String]) {
        tasks.forEach { task in
            app.buttons[Identifiers.addTaskButton].tap()
            let titleField = app.textFields[Identifiers.titleLabel]
            titleField.tap()
            titleField.typeText(task)
            app.buttons[Identifiers.saveButton].tap()
        }
    }
    
    func setupTasksAllInformation() {
        app.buttons[Identifiers.addTaskButton].tap()
        enterTaskDetails(
            title: "Task1",
            comment: "comment",
            url: "https://www.google.co.jp/",
            status: MockTaskStatus.inProgress,
            dueDate: DateComponents(year: 2040, month: 1, day: 2, hour: 15, minute: 31)
        )
        app.buttons[Identifiers.saveButton].tap()
    }
    
    private func enterTaskDetails(title: String, comment: String, url: String, status: MockTaskStatus, dueDate: DateComponents) {
        app.textFields[Identifiers.titleLabel].tap()
        app.textFields[Identifiers.titleLabel].typeText(title)
        
        app.textFields[Identifiers.commentField].tap()
        app.textFields[Identifiers.commentField].typeText(comment)
        
        app.textFields[Identifiers.urlLabel].tap()
        app.textFields[Identifiers.urlLabel].typeText(url)
        
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + MockTaskStatus.notStarted.title]
        statusButton.tap()
        app.buttons[status.title].tap()
        
        pickDate(dueDate)
    }
    
    func pickDate(_ dateComponents: DateComponents) {
        if let month = dateComponents.month {
            app.pickerWheels.element(boundBy: DatePickerComponent.month.rawValue).adjust(toPickerWheelValue: "\(month)")
        }
        if let day = dateComponents.day {
            app.pickerWheels.element(boundBy: DatePickerComponent.day.rawValue).adjust(toPickerWheelValue: "\(day)")
        }
        if let year = dateComponents.year {
            app.pickerWheels.element(boundBy: DatePickerComponent.year.rawValue).adjust(toPickerWheelValue: "\(year)")
        }
        if let hour = dateComponents.hour {
            app.pickerWheels.element(boundBy: DatePickerComponent.hour.rawValue).adjust(toPickerWheelValue: "\(hour)")
        }
        if let minute = dateComponents.minute {
            app.pickerWheels.element(boundBy: DatePickerComponent.minute.rawValue).adjust(toPickerWheelValue: "\(minute)")
        }
        if let hour = dateComponents.hour, hour >= 12 {
            app.pickerWheels.element(boundBy: DatePickerComponent.period.rawValue).adjust(toPickerWheelValue: "PM")
        } else {
            app.pickerWheels.element(boundBy: DatePickerComponent.period.rawValue).adjust(toPickerWheelValue: "AM")
        }
    }
}
