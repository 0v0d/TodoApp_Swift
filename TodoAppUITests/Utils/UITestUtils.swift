//
//  UITestUtils.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/10.
//
import XCTest

final class UITestUtils {
    private let taskSetup: TaskSetupUtils
    private let uiInteraction: UIInteractionUtils
    private let assertions: AssertionsUtils

    init(app: XCUIApplication) {
        taskSetup = TaskSetupUtils(app: app)
        uiInteraction = UIInteractionUtils(app: app)
        assertions = AssertionsUtils(app: app)
    }
    
    /// テスト用のタスクをセットアップする
    func setupTasksForTesting(tasks: [String] = ["test"]) {
        taskSetup.setupTasksForTesting(tasks: tasks)
    }
    
    func setupTasksAllInformation() {
        taskSetup.setupTasksAllInformation()
    }
    
    func tapAddTaskButton() {
        uiInteraction.tapAddTaskButton()
    }

    func tapSaveButton() {
      uiInteraction.tapSaveButton()
    }

    func tapEditButton() {
       uiInteraction.tapEditButton()
    }

    func tapTaskCell() {
     uiInteraction.tapTaskCell()
    }

    func enterTextField(identifier: String, text: String) {
        uiInteraction.enterTextField(identifier: identifier, text: text)
    }
   
    func assertStaticText(identifier: String, value: String?) {
        assertions.assertStaticText(identifier: identifier, value: value)
        
    }

    func assertElementExists(_ element: XCUIElement, exists: Bool)  {
        assertions.assertElementExists(element, exists: exists)
    }
    
    func assertElementIsEnabled(_ element: XCUIElement, isEnabled: Bool) {
        assertions.assertElementIsEnabled(element, isEnabled: isEnabled)
    }

    func assertDate(label: String, withinSeconds: TimeInterval = 60) {
        assertions.assertDate(label: label, withinSeconds: withinSeconds)
    }
    
    func pickDate(_ date: DateComponents) {
        taskSetup.pickDate(date)
    }
    
    func tapStatusPicker(_ currentStatus: MockTaskStatus){
        uiInteraction.tapStatusPicker(currentStatus: currentStatus)
    }
}
