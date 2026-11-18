import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Section("Режим работы") {
                    Label("Локальная модель — будет подключена", systemImage: "iphone")
                    Label("Интернет и сервер — будут подключены", systemImage: "globe")
                }

                Section("Память и знания") {
                    Label("История диалогов — следующий этап", systemImage: "clock")
                    Label("Личная база знаний — следующий этап", systemImage: "books.vertical")
                    Label("Веб-поиск — следующий этап", systemImage: "magnifyingglass")
                }

                Section {
                    Text("AION — независимый проект на базе открытых моделей. Сейчас это стартовый интерфейс, а не готовая языковая модель.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
