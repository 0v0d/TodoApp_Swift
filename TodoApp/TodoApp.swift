//
//  GmoriAppApp.swift
//  GmoriApp
//
//  Created by 0v0 on 2024/10/24.
//

import SwiftUI

@main
struct TodoApp: App {
    private let repository: TaskRepositoryIMPL?
    private let viewModel: TaskViewModel?

    init() {
        do {
            self.repository = try TaskRepositoryIMPL()
            self.viewModel = TaskViewModel(repository: repository!)
        } catch {
            print("Failed to initialize TaskRepositoryIMPL: \(error.localizedDescription)")
            self.repository = nil
            self.viewModel = nil
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if let viewModel = viewModel {
                HomeView()
                    .environmentObject(viewModel)
            } else {
                Text("アプリの初期化に失敗しました")
                    .foregroundColor(.red)
                    .font(.title)
            }
        }
    }
}

