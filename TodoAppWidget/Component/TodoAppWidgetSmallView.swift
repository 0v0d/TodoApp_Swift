//
//  TodoAppWidgetSmallView.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/29.
//
import SwiftUI

struct TodoAppWidgetSmallView: View {
    let task: Todo
    var body: some View {

        VStack(alignment: .leading) {
            InfoWidgetRow(title: "Title", content: task.title, icon: "doc.text")

            Divider()

            StatusInfoWidgetRow(status: task.status, icon: "checkmark.circle.fill")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
