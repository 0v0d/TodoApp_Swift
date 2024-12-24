//
//  TodoAppWidget.swift
//  TodoAppWidget
//
//  Created by 0v0 on 2024/11/25.
//
import SwiftUI
import WidgetKit

/// ウィジェットのタイムライン更新時に使用されるエントリー
///
/// - Properties:
///   - date: タイムラインの更新日時
///   - task: 表示するタスク。nilの場合は空の状態を表示
struct TodoEntry: TimelineEntry {
    let date: Date
    let task: Todo?
}

/// Todoアプリケーションのウィジェット
///
/// このウィジェットは以下の機能を提供します：
/// - アクティブなタスクの表示
/// - 異なるウィジェットサイズ（Small、Medium、Large、ExtraLarge）のサポート
/// - 15分ごとの自動更新
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

/// ウィジェットのサイズに応じて適切なビューを表示する
///
/// ウィジェットファミリー別の表示内容：
/// - systemSmall: タイトルとステータスのみ
/// - systemMedium: 基本情報と期限
/// - systemLarge: 詳細情報を含む
/// - systemExtraLarge: 全ての情報を表示
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
    TodoEntry(date: .now, task: TodoTestData.todos[0])
    TodoEntry(date: .now, task: TodoTestData.todos[1])
    TodoEntry(date: .now, task: nil)
}

#Preview(as: .systemMedium) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TodoTestData.todos[0])
    TodoEntry(date: .now, task: TodoTestData.todos[1])
    TodoEntry(date: .now, task: nil)
}

#Preview(as: .systemLarge) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TodoTestData.todos[0])
    TodoEntry(date: .now, task: TodoTestData.todos[1])
    TodoEntry(date: .now, task: nil)
}

#Preview(as: .systemExtraLarge) {
    TodoAppWidget()
} timeline: {
    TodoEntry(date: .now, task: TodoTestData.todos[0])
    TodoEntry(date: .now, task: TodoTestData.todos[1])
    TodoEntry(date: .now, task: nil)
}
