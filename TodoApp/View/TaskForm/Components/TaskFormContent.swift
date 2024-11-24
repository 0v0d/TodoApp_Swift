//
//  TaskFormContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct TaskFormContent:View{
    @Binding var formData: TaskFormData
    
    var body: some View{
        VStack(spacing: 20) {
            TitleInputField(title: $formData.title)
            
            CommentInputField(comment: $formData.comment)
            
            URLInputField(url: $formData.url)
            
            TaskStatusPickerSection(selectedValue: $formData.selectedValue)
            
            DueDatePickerSection(dueDate: $formData.dueDate)
            Spacer()
        }
        .padding()
    }
}
