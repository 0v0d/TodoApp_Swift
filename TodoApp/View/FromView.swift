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
    var topBarTitle: String
    @State private var isShowError = false
    var action: (() -> Void)
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 20) {
                    InputField(
                        title: "タイトル",
                        placeholder: "タイトルを入力",
                        text: $title,
                        isRequired: true,
                        showError: $isShowError,
                        errorMessage: "タイトルを入力してください"
                    ).padding(.top, 10)
                    
                    InputField(
                        title: "コメント",
                        placeholder: "コメントを入力",
                        text: $comment,
                        isRequired: false,
                        lineLimitRange: 3...6
                    )
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("期日")
                            .font(.headline)
                            .foregroundColor(.secondary)
                        
                        // 日付選択
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
                        // 時間選択（ドラムロール式）
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
            isShowError = false
            action()
            dismiss()
        } else {
            isShowError = true
        }
    }
    
    private var isValidInput: Bool {
        !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var showError: Binding<Bool>? = nil
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
            
            if let showError = showError, showError.wrappedValue, let errorMessage = errorMessage {
                Text(errorMessage)
                    .font(.footnote)
                    .foregroundColor(.red)
                    .padding(.leading, 5)
            }
        }
    }
}

#Preview {
    @Previewable @State var title = ""
    @Previewable @State var comment = ""
    @Previewable @State var dueDate = Date()
    let action = {}
    let topBarTitle = "新規タスク"
    TaskFormView(
        title: $title,
        comment: $comment,
        dueDate: $dueDate,
        topBarTitle: topBarTitle,
        action: action
    )
}
