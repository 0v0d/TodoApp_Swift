//
//  TaskStatusPickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct TaskStatusPickerSection: View {
    @Binding var status: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Status")
                .font(.headline)
                .foregroundColor(.secondary)

            Picker("Status", selection: $status) {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(LocalizedStringKey(status.title))
                        .tag(status.rawValue)
                }
            }
            .pickerStyle(.menu)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
