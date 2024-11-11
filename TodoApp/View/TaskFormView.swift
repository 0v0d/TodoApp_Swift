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
    @Binding var dueDate: Date
    @Binding var selectedValue: Int
    var topBarTitle: String
    var action: (() -> Void)
    
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
                .navigationTitle(topBarTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("キャンセル") {
                            dismiss()
                        }
                        .foregroundColor(.blue)
                    }
                    ToolbarItem(placement: .primaryAction) {
                        Button("保存") {
                            handleSaveAction()
                        }
                        .disabled(!isValidInput)
                        .foregroundColor(isValidInput ? .blue : .gray)
                    }
                }
            }
        }
    }
    
    private func handleSaveAction() {
        if isValidInput {
            action()
            dismiss()
        }
    }
    
    private var isValidInput: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

// タイトル入力フィールド
private struct TitleInputField: View {
    @Binding var title: String
    
    var body: some View {
        InputField(
            title: "タイトル",
            placeholder: "タイトルを入力",
            text: $title,
            isRequired: true,
            errorMessage: "タイトルを入力してください"
        )
        .padding(.top, 10)
    }
}

// コメント入力フィールド
private struct CommentInputField: View {
    @Binding var comment: String
    
    var body: some View {
        InputField(
            title: "コメント",
            placeholder: "コメントを入力",
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
    @Binding var dueDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ステータス")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Picker("", selection: $selectedValue) {
                Text(Status.notStarted.displayText).tag(0)
                Text(Status.inProgress.displayText).tag(1)
                Text(Status.completed.displayText).tag(2)
            }
            .pickerStyle(.wheel)
            
            Text("期日")
                .font(.headline)
                .foregroundColor(.secondary)
            
            DatePicker(
                "日付を選択",
                selection: $dueDate,
                displayedComponents: [.date]
            )
            .datePickerStyle(.graphical)
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            
            Text("時間")
                .font(.headline)
                .foregroundColor(.secondary)
            
            DatePicker(
                "時間を選択",
                selection: $dueDate,
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
    var errorMessage: String? = nil
    var lineLimitRange: ClosedRange<Int>?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                if isRequired {
                    Text("*")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
            
            TextField(placeholder, text: $text, axis: lineLimitRange == nil ? .horizontal : .vertical)
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
    @Previewable @State var dueDate = Date()
    @Previewable @State var selectedValue = 0
    let action = {}
    let topBarTitle = "新規タスク"
    TaskFormView(
        title: $title,
        comment: $comment,
        dueDate: $dueDate,
        selectedValue: $selectedValue,
        topBarTitle: topBarTitle,
        action: action
    )
}
