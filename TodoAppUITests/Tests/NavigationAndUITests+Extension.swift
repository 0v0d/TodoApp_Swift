//
//  NavigationAndUITests+Extension.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/15.
//
import XCTest

extension NavigationAndUITests {
    func verifyTaskFormView() {
        let saveButton = application.buttons[Identifiers.saveButton]
        utils.assertElementExists(saveButton, exists: true)

        let cancelButton = application.buttons[Identifiers.cancelButton]
        utils.assertElementExists(cancelButton, exists: true)

        // Title
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.titleLabel,
            requiredLabel: "*",
            textFieldLabel: Identifiers.titleLabel
        )

        // Comments
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.commentLabel,
            textFieldLabel: Identifiers.commentField
        )

        // URL
        verifyStaticTextAndTextField(
            staticLabel: Identifiers.urlLabel,
            textFieldLabel: Identifiers.urlLabel
        )

        utils.assertStaticText(identifier: Identifiers.statusLabel, value: nil)
        
        utils.tapStatusPicker(.notStarted)

        XCTAssertEqual(application.pickers.count, 2, "Picker should exist")

        verifyDueDatePicker()

        verifyTimePicker()
    }

    private func verifyDueDatePicker() {
        utils.assertStaticText(identifier: Identifiers.dueDateLabel, value: nil)

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

        utils.assertStaticText(identifier: "Time", value: nil)

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
        utils.assertStaticText(identifier: staticLabel, value: nil)

        if let requiredLabel = requiredLabel {
            utils.assertStaticText(identifier: requiredLabel, value: nil)
        }

        let textField = application.textFields[textFieldLabel]
        utils.assertElementExists(textField, exists: true)
    }
}
