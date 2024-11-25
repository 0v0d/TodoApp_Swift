//
//  InfoRow.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/24.
//
import SwiftUI

struct InfoRow: View {
    let title: String
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(LocalizedStringKey(title))
                .font(.caption)
                .foregroundColor(.secondary)

            if let url = URL(string: content),
               UIApplication.shared.canOpenURL(url) {
                HStack {
                    Link(content, destination: url)
                        .font(.body)
                        .foregroundColor(.blue)
                }
            } else {
                Text(content)
                    .font(.body)
                    .contextMenu {
                        Button(action: {
                            UIPasteboard.general.string = content
                        }, label: {
                            Text("Copy")
                            Image(systemName: "document.on.document")
                        })
                    }
            }
        }
    }
}
