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
            
            dueDate: DateComponents(year: 2040, month:1 , day: 2, hour: 15, minute: 31)
        )
        app.buttons[Identifiers.saveButton].tap()
    }
    
    private func enterTaskDetails(title: String, comment: String, url: String, status: MockTaskStatus, dueDate: DateComponents) {
        enterText(field: Identifiers.titleLabel, text: title)
        enterText(field: Identifiers.commentField, text: comment)
        enterText(field: Identifiers.urlLabel, text: url)
        
        selectStatus(selectStatus: status)
        pickDate(dueDate)
    }
    
    // テキストフィールドにテキストを入力する共通処理
    private func enterText(field: String, text: String) {
        let textField = app.textFields[field]
        textField.tap()
        textField.typeText(text)
    }
    
    func pickDate(_ dateComponents: DateComponents) {
        let monthNames = ["January", "February", "March", "April", "May", "June",
                          "July", "August", "September", "October", "November", "December"]
        
        // 対応する値を計算するクロージャ
        let pickerValues: [DatePickerComponent: String?] = [
            .month: dateComponents.month.flatMap { month in
                // 1-12の範囲チェック
                (1...12).contains(month) ? monthNames[month - 1] : nil
            },
            .day: dateComponents.day.map { "\($0)" },
            .year: dateComponents.year.map { "\($0)" },
            .hour: dateComponents.hour.map {
                let hour12 = $0 > 12 ? $0 - 12 : $0
                return "\($0 == 0 ? 12 : hour12)"
            },
            .ampm: dateComponents.hour.map { $0 >= 12 ? "PM" : "AM" },
            .minute: dateComponents.minute.map { "\($0)" }
        ]
        
        // Picker Wheel を調整
        pickerValues.forEach { component, value in
            if let value = value {
                app.pickerWheels.element(boundBy: component.rawValue).adjust(toPickerWheelValue: value)
            }
        }
    }
    
    // PickerWheel の調整を共通化
    private func adjustPickerWheel(component: DatePickerComponent, value: String) {
        app.pickerWheels.element(boundBy: component.rawValue).adjust(toPickerWheelValue: value)
    }
    
    // ステータスを選択する処理
    private func selectStatus(selectStatus: MockTaskStatus) {
        let statusButton = app.buttons[Identifiers.statusLabel + ", " + MockTaskStatus.notStarted.title]
        XCTAssertTrue(statusButton.exists)
        statusButton.tap()
        
        let selectStatusButton = app.buttons[selectStatus.title]
        print(selectStatus.title)
        selectStatusButton.tap()
    }
}
