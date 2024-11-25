//
//  TodoApp.swift
//  TodoApp
//
//  Created by 0v0 on 2024/10/24.
//
import SwiftUI

@main
struct TodoApp: App {
    let viewModel: TaskViewModel
    init() {
        viewModel = DIContainer.shared.makeTaskViewModel()
    }
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(viewModel)
        }
    }
}
