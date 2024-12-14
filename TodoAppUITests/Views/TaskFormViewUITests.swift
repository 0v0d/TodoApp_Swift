//
//  AddTaskViewUITests.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//
import XCTest

final class AddTaskViewUITests: XCTestCase {
    var application: XCUIApplication!
    var utils: UITestUtils!

    override func setUp() {
        super.setUp()
        application = setupUITest()
        utils = UITestUtils(app: application)
    }

    override func tearDown() {
        teardownUITest(application)
        application = nil
        super.tearDown()
    }
    
    @MainActor
    func testAddTaskView() {
        application.buttons[AccessibilityIdentifiers.addTaskButton].tap()

        XCTAssertTrue(application.navigationBars["New Task"].exists,
                      "Navigation bar should exist")
        
        verifyTaskView()
    }
    
    
    @MainActor
    func testEditTaskView() {
        TestHelper.tapFirstTaskInList(app: application)
        application.buttons[AccessibilityIdentifiers.editButton].tap()

        XCTAssertTrue(application.navigationBars["Edit Task"].exists,
                      "Navigation bar should exist")
        
        verifyTaskView()
    }

    
    private func verifyTaskView() {
        utils.assertButton(label: AccessibilityIdentifiers.saveButton)
        utils.assertButton(label: AccessibilityIdentifiers.cancelButton)

        // Title
        verifyStaticTextAndTextField(
            staticLabel: "Title",
            requiredLabel: "*",
            textFieldLabel: AccessibilityIdentifiers.titleField
        )

        // Comments
        utils.assertStaticText(label: "Comments", value: nil)
        utils.assertTextField(label: AccessibilityIdentifiers.commentField)

        // URL
        verifyStaticTextAndTextField(
            staticLabel: "URL",
            textFieldLabel: AccessibilityIdentifiers.urlField
        )

        utils.assertStaticText(label: "Status", value: nil)
        utils.assertButton(label: AccessibilityIdentifiers.statusPicker)

        XCTAssertTrue(application.pickers.count == 2, "Picker should exist")

        verifyDueDatePicker()

        verifyTimePicker()
    }
        
    
    private func verifyDueDatePicker() {
        utils.assertStaticText(label: "Due Date", value: nil)

        let date = Date()
        let locale = Locale(identifier: "en_US")

        let monthName = date.formatted(.dateTime.month(.wide).locale(locale))
        XCTAssertEqual(
            application.pickerWheels.element(boundBy: 0).value as? String,
            monthName,
            "Month should match"
        )

        let day = date.formatted(.dateTime.day().locale(locale))
        XCTAssertEqual(
            application.pickerWheels.element(boundBy: 1).value as? String,
            day,
            "Day should match"
        )
    }

    private func verifyTimePicker() {
        application.swipeDown()

        utils.assertStaticText(label: "Time", value: nil)

        let timePickerWheels = [2, 3, 4]
        timePickerWheels.forEach { index in
            XCTAssertTrue(
                application.pickerWheels.element(boundBy: index).exists,
                "Time picker wheel at index \(index) should exist"
            )
        }
    }

    private func verifyStaticTextAndTextField(
        staticLabel: String,
        requiredLabel: String? = nil,
        textFieldLabel: String
    ) {
        utils.assertStaticText(label: staticLabel, value: nil)

        if let requiredLabel = requiredLabel {
            utils.assertStaticText(label: requiredLabel, value: nil)
        }

        utils.assertTextField(label: textFieldLabel)
    }
}
