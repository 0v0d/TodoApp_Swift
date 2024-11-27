//
//  TodoAppWidget.swift
//  TodoAppWidget
//
//  Created by 0v0 on 2024/11/25.
//
import SwiftUI
import WidgetKit

struct TodoEntry: TimelineEntry {
    let date: Date
    let task: Todo?
}

struct TodoAppWidget: Widget {
    let kind = "TodoAppWidget"
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: TodoProvider()
        ) { entry in
            VStack(alignment: .leading, spacing: 10) {
                if let task = entry.task {
                    TodoAppWidgetContent(task: task)
                } else {
                    EmptyWidgetView()
                }
            }.containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

#Preview(as: .systemSmall) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TestData.todos[0])
    TodoEntry(date: .now, task: TestData.todos[1])
    TodoEntry(date: .now, task: nil)
}
