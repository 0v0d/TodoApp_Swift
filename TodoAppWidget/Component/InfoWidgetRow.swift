//
//  TodoAppWidgetContent.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import SwiftUI

struct InfoWidgetRow: View {
    let title: String
    let content: String
    let icon: String

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            if !icon.isEmpty {
                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.accentColor)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(LocalizedStringKey(title))
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                Text(content)
                    .font(.body)
                    .foregroundColor(.primary)
            }
        }
        .padding(.vertical, 8)
    }
}
