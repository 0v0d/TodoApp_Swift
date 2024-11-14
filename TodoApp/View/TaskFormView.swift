//
//  FromView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var title: String
    @Binding var comment: String
    @Binding var dueDate: Date?
    @Binding var selectedValue: Int
    var topBarTitle: String
    var action: (() -> Void)
    
    private var isError: Bool {
        title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        || dueDate != nil && dueDate ?? Date() < Date()
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    TitleInputField(title: $title)
                    CommentInputField(comment: $comment)
                    StatusAndDatePicker(
                        selectedValue: $selectedValue,
                        dueDate: $dueDate
                    )
                    Spacer()
                }
                .padding()
                .navigationTitle(LocalizedStringKey(topBarTitle))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.blue)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button("Save") {
                            handleSaveAction()
                        }
                        .disabled(isError)
                        .foregroundColor(!isError ? .blue : .gray)
                    }
                }
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

// タイトル入力フィールド
private struct TitleInputField: View {
    @Binding var title: String
    
    var body: some View {
        InputField(
            title: "Title",
            placeholder: "EnterTitle",
            text: $title,
            isRequired: true
        )
        .padding(.top, 10)
    }
}

// コメント入力フィールド
private struct CommentInputField: View {
    @Binding var comment: String
    
    var body: some View {
        InputField(
            title: "Comment",
            placeholder: "EnterComment",
            text: $comment,
            isRequired: false,
            lineLimitRange: 3...6
        )
        .padding(.top, 10)
    }
}

// ステータスと日付選択
private struct StatusAndDatePicker: View {
    @Binding var selectedValue: Int
    @Binding var dueDate: Date?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Status")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Picker("", selection: $selectedValue) {
                ForEach(Status.allCases, id: \.self) { status in
                    Text(LocalizedStringKey(status.displayText))
                        .tag(status.rawValue)
                }
            }
            .pickerStyle(.wheel)
            
            Text("DueDate")
                .font(.headline)
                .foregroundColor(.secondary)
            
            if dueDate ?? Date() < Date() {
                Text("DueDateError")
                    .font(.headline)
                    .foregroundColor(.red)
            }
            
            DatePicker(
                "SelectDate",
                selection: Binding(
                    get: { dueDate ?? Date() },
                    set: { newDate in
                        dueDate = newDate
                    }
                ),
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            
            Text("Time")
                .font(.headline)
                .foregroundColor(.secondary)
            
            DatePicker(
                "SelectTime",
                selection: Binding(
                    get: { dueDate ?? Date() },
                    set: { newDate in dueDate = newDate }
                ),
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(.wheel)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
        }
    }
}

private struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var lineLimitRange: ClosedRange<Int>?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 0) {
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                if isRequired {
                    Text("*")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            
            TextField(
                LocalizedStringKey(placeholder),
                text: $text,
                axis: lineLimitRange == nil ? .horizontal : .vertical
            )
            .padding()
            .accessibilityLabel(title)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            .lineLimit(lineLimitRange ?? 5...10)
        }
    }
}

#Preview {
    @Previewable @State var title = ""
    @Previewable @State var comment = ""
    @Previewable @State var dueDate: Date? = nil
    @Previewable @State var selectedValue = 0
    let action = {}
    let topBarTitle = "NewTask"
    TaskFormView(
        title: $title,
        comment: $comment,
        dueDate: $dueDate,
        selectedValue: $selectedValue,
        topBarTitle: topBarTitle,
        action: action
    )
}
