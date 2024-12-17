//
//  InputFields.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

struct TitleInputField: View {
    @Binding var title: String

    var body: some View {
        InputField(
            title: "Title",
            placeholder: "EnterTitle",
            text: $title,
            isRequired: true,
            lineLimitRange: 1...3
        )
    }
}

struct CommentInputField: View {
    @Binding var comment: String

    var body: some View {
        InputField(
            title: "Comment",
            placeholder: "EnterComment",
            text: $comment,
            isRequired: false,
            lineLimitRange: 3...6
        )
        .padding(.top, 10)
    }
}

struct URLInputField: View {
    @Binding var url: String

    var body: some View {
        VStack(spacing: 4) {
            InputField(
                title: "URL",
                placeholder: "EnterURL",
                text: $url,
                isRequired: false,
                lineLimitRange: 1...3
            )

            if !url.isEmpty && !URLValidator().isValid(url) {
                ErrorLabel(message: "invalidURLMessage")
            }
        }
    }
}

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var isRequired: Bool = false
    var lineLimitRange: ClosedRange<Int>?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(LocalizedStringKey(title))
                    .font(.headline)
                    .foregroundColor(.secondary)

                if isRequired {
                    Text("*")
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }

            TextField(
                LocalizedStringKey(placeholder),
                text: $text,
                axis: lineLimitRange == nil ? .horizontal : .vertical
            )
            .padding()
            .accessibilityLabel(title)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(15)
            .lineLimit(lineLimitRange ?? 5...10)
        }
    }
}
