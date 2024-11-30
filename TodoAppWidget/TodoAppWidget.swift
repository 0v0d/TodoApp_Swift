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
                    TodoAppWidgetEntryView(task: task)
                } else {
                    EmptyWidgetView()
                }
            }.containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

struct TodoAppWidgetEntryView: View {
    @Environment(\.widgetFamily) var family: WidgetFamily
    let task: Todo

    var body: some View {
        switch family {
        case .systemSmall:
            TodoAppWidgetSmallView(task: task)
        case .systemMedium:
            TodoAppWidgetMediumView(task: task)
        case .systemLarge:
            TodoAppWidgetLargeView(task: task)
        case .systemExtraLarge:
            TodoAppWidgetExtraLargeView(task: task)
        default:
            EmptyWidgetView()
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

#Preview(as: .systemMedium) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TestData.todos[0])
    TodoEntry(date: .now, task: TestData.todos[1])
    TodoEntry(date: .now, task: nil)
}

#Preview(as: .systemLarge) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TestData.todos[0])
    TodoEntry(date: .now, task: TestData.todos[1])
    TodoEntry(date: .now, task: nil)
}

#Preview(as: .systemExtraLarge) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TestData.todos[0])
    TodoEntry(date: .now, task: TestData.todos[1])
    TodoEntry(date: .now, task: nil)
}
