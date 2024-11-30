//
//  StatusInfo.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct StatusInfo: View {
    let status: TaskStatus

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey("Status"))
                .font(.caption)
                .foregroundColor(.secondary)

            TaskStatusText(status: status, fontSize: .body)
        }
    }
}
