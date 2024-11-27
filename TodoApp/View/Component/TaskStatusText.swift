//
//  TaskStatusText.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

struct TaskStatusText: View {
    let status: TaskStatus
    let fontSize: Font

    var body: some View {
        Text(LocalizedStringKey(status.title))
            .font(fontSize)
            .padding(.horizontal, 8)
            .padding(.vertical, 6)
            .background(status.color.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
