//
//  AddTaskButton.swift
//  TodoApp
//
//  Created by 0v0 on 2024/12/04.
//
import SwiftUI

struct AddTaskButton: View {
    @Binding var showingAddTask: Bool

    var body: some View {
        Button {
            showingAddTask = true
        } label: {
            Image(systemName: "square.and.pencil")
                .accessibilityLabel("NewTask")
                .fontWeight(.bold)
                .foregroundColor(.blue)
        }
    }
}
