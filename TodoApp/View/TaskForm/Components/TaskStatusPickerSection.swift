//
//  TaskStatusPickerSection.swift
//  TodoApp
//
//  Created by 0v0 on 2024/11/15.
//
import SwiftUI

/// タスクの状態を選択するためのPickerを表示
///
/// - Parameters:
/// - `status`: タスクの状態（`Int` 型）
struct TaskStatusPickerSection: View {

    @Binding var status: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Status")
                .font(.headline)
                .foregroundColor(.secondary)

            // タスクの状態を選択するためのPickerを表示
            Picker("Status", selection: $status) {
                // TaskStatusの全てのケースを取得し、それぞれのタイトルを表示
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Text(LocalizedStringKey(status.title))
                        .tag(status.rawValue)
                }
            }
            .pickerStyle(.menu) // メニュースタイルで表示
            .frame(maxWidth: .infinity, alignment: .leading) // 幅いっぱいで左寄せで表示
        }
    }
}
