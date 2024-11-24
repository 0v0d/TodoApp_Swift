//
//  TaskFormView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var formData: TaskFormData
    var topBarTitle: String
    var action: (() -> Void)
    
    private var isError: Bool {
        formData.title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || !DateValidator().isDueDateValid(formData.dueDate)
        || (!formData.url.isEmpty && !URLValidator().isValid(formData.url))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                TaskFormContent(formData: $formData)
                    .navigationTitle(LocalizedStringKey(topBarTitle))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        formToolbar
                    }
            }
        }
    }
    
    private var formToolbar: some ToolbarContent {
        Group {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
                    .foregroundColor(.blue)
            }
            
            ToolbarItem(placement: .primaryAction) {
                Button("Save") { handleSaveAction() }
                    .disabled(isError)
                    .foregroundColor(!isError ? .blue : .gray)
            }
        }
    }
    
    private func handleSaveAction() {
        if !isError {
            action()
            dismiss()
        }
    }
}

#Preview {
    @Previewable @State var formData = TaskFormData()
    let action = {}
    let topBarTitle = "NewTask"
    TaskFormView(
        formData: $formData,
        topBarTitle: topBarTitle,
        action: action
    )
}
