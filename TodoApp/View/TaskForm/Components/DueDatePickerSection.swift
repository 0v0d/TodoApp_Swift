//
//  DueDatePickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct DueDatePickerSection: View {
    @Binding var dueDate: Date?
    let dateValidator = DateValidator()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            DueDatePickerRow(
                dueDate: $dueDate,
                title: "DueDate",
                errorMessage: "DueDateError",
                pickerTitle: "SelectDate",
                isDatePicker: true,
                isError: !dateValidator.isDueDateValid(dueDate)
            )
            
            DueDatePickerRow(
                dueDate: $dueDate,
                title: "Time",
                errorMessage: "TimeError",
                pickerTitle: "SelectTime",
                isDatePicker: false,
                isError: !dateValidator.isTimeValid(dueDate)
            )
        }
    }
}

private struct DueDatePickerRow: View {
    @Binding var dueDate: Date?
    let title: LocalizedStringKey
    let errorMessage: LocalizedStringKey
    let pickerTitle: LocalizedStringKey
    var isDatePicker: Bool = true
    let isError: Bool
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.secondary)
        
        if isError {
            Text(errorMessage)
                .font(.headline)
                .foregroundColor(.red)
        }
        
        DatePicker(
            pickerTitle,
            selection: Binding(
                get: { dueDate ?? Date() },
                set: { newDate in dueDate = newDate }
            ),
            displayedComponents: [isDatePicker ? .date : .hourAndMinute]
        )
        .datePickerStyle(.wheel)
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}
