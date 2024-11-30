//
//  TodoProvider.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/27.
//
import WidgetKit

struct TodoProvider: @preconcurrency TimelineProvider {
    func getTimeline(in context: Context, completion: @escaping @Sendable (Timeline<TodoEntry>) -> Void) {
        Task {
            do {
                let viewModel = DIContainer.shared.makeWidgetViewModel()
                let task = try await viewModel.fetchActiveTask()

                let entry = TodoEntry(date: Date(), task: task)
                let nextUpdate = Date().addingTimeInterval(60 * 15)
                let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
                completion(timeline)

                completion(timeline)
            } catch {
                let timeline = Timeline(
                    entries: [TodoEntry(date: Date(), task: nil)],
                    policy: .atEnd
                )
                completion(timeline)
            }
        }
    }

    @MainActor
    func placeholder(in context: Context) -> TodoEntry {
        TodoEntry(date: Date(), task: TestData.todos[0])
    }

    @MainActor
    func getSnapshot(in context: Context,
                     completion: @escaping (TodoEntry) -> Void) {
        Task {
            do {
                let viewModel = DIContainer.shared.makeWidgetViewModel()
                let activeTask = try await viewModel.fetchActiveTask()
                let task = TodoEntry(date: Date(), task: activeTask)
                completion(task)
            } catch {
                completion(TodoEntry(date: Date(), task: nil))
            }
        }
    }
}
