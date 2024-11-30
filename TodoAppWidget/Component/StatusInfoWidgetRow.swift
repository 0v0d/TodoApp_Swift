//
//  StatusInfoWidgetRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/30.
//
import SwiftUI

struct StatusInfoWidgetRow: View {
    let status: TaskStatus
    let icon: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(status.color)
                    .shadow(color: status.color.opacity(0.4), radius: 4, x: 0, y: 2)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey("Status"))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                TaskStatusText(status: status, fontSize: .body)
            }
        }
        .padding(.vertical, 8)
    }
}
