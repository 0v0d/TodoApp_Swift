# **TodoApp**

## **概要**
TodoApp は、Swift の学習を目的として開発されたタスク管理アプリです。  

## 📱 **主な機能**

- **タスクの一覧表示**  
  登録済みのタスクをリスト形式で表示します。

- **タスクの追加**  
  新しいタスクを簡単に登録できます。

- **タスクの編集**  
  登録済みのタスクを更新できます。

- **タスクの削除**  
  不要なタスクや完了済みタスクを削除可能。

- **ウィジェット**  
  タスクの期限が近いものをホーム画面で表示します。

## 🛠 **使用技術**

- **SwiftUI**: 宣言的 UI フレームワーク  
- **SwiftData**: データ保存と永続化  
- **MVVM アーキテクチャ**: モジュール間の責務を明確化  
- **Repository パターン**: データ管理の抽象化と効率化  
- **Dependency Injection (DI)**: モジュール間の疎結合化


## 🎨 **画面構成**

1. **タスク一覧画面**  
   - 登録済みのタスクをリストで表示します。
   - タスクを選択すると、詳細画面に遷移します。

2. **タスク追加画面**  
   - 新しいタスクを登録する画面です。
   - タスク名、詳細、期日などを入力できます。

3. **タスク編集画面**  
   - 既存のタスク情報を編集できます。

4. **タスク詳細画面**  
   - タスクの詳細情報を確認する画面です。
   - 必要に応じて編集画面に遷移できます。

5. **ウィジェット**  
   - 期限が近いタスクの詳細をウィジェットで表示します。


## 🗂 **ディレクトリ構造**

```
TodoApp/
├── App                 // アプリのエントリーポイントと DI コンテナ
├── Core                // 再利用可能な拡張機能やユーティリティ
├── Domain              // ビジネスロジックとデータモデル
├── Features            // 各機能 (Add/Edit, Home, Detail, List) のモジュール
├── Resource            // アセットやローカライズファイル
└── Widgets             // ウィジェット関連のコード
```

### **詳細**

#### **1. App**
- **`TodoApp.swift`**: アプリのメインエントリーポイント  
- **`DIContainer.swift`**: 依存性注入の管理

#### **2. Core**
- **Extensions**: 汎用的な拡張機能  
  - 例: `Date+Extension.swift`
- **Utils**: 各種バリデーション処理  
  - 例: `DateValidator.swift`, `URLValidator.swift`

#### **3. Domain**
- **Model**: ビジネスロジックを担うデータモデル  
  - 例: `Todo.swift`, `TodoFormData.swift`
- **Repository**: データ管理の抽象化  
  - 例: `TodoRepository.swift`, `TodoRepositoryIMPL.swift`

#### **4. Features**
- **`AddEditTodo`**: タスクの追加/編集画面  
  - 例: `AddTodoView.swift`, `EditTodoView.swift`
- **`Home`**: ホーム画面  
  - 例: `HomeView.swift`, `HomeViewModel.swift`
- **`TodoDetail`**: タスク詳細画面  
  - 例: `TodoDetailView.swift`, `InfoRow.swift`
- **`TodoList`**: タスク一覧画面  
  - 例: `TodoListView.swift`

#### **5. Resource**
- **アセット管理**: `Preview Content`、ローカライズファイル (`Localizable.xcstrings`)

#### **6. Widgets**
- **ViewModel**: ウィジェットでのデータ管理  
  - 例: `WidgetTaskViewModel.swift`

## 🎬 **デモ動画**
<img src="app.gif" width="320" alt="アプリのデモ動画">
