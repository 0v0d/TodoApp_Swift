//
//  FromView.swift
//  GmoriApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

struct TaskFormView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var title: String
    @Binding var comment: String
    var topBarTitle: String
    @State private var isShowError = false
    var action: (() -> Void)
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                InputField(
                    title: "タイトル",
                    placeholder: "タイトルを入力",
                    text: $title,
                    isRequired: true,
                    showError: $isShowError,
                    errorMessage: "タイトルを入力してください"
                )
                
                InputField(
                    title: "コメント",
                    placeholder: "コメントを入力",
                    text: $comment,
                    isRequired: false,
                    lineLimitRange: 3...6
                )
                .padding(.top, 10)
                
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
    let action = {}
    let topBarTitle = "新規タスク"
    TaskFormView(title: $title, comment: $comment, topBarTitle: topBarTitle, action: action)
}
