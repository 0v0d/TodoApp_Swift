//
//  TaskStatusPickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct TaskStatusPickerSection: View {
    @Binding var selectedValue: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Status")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Picker("", selection: $selectedValue) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(LocalizedStringKey(status.title))
                        .tag(status.rawValue)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
