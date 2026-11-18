import Foundation
import SwiftUI

@MainActor
final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [
        ChatMessage(role: .assistant, text: "Привет! Я AION. Подключение языковой модели — следующий этап нашей разработки.")
    ]
    @Published var draft = ""
    @Published var isWorking = false

    private let service: AIService = DemoAIService()

    func send() {
        let text = draft.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty, !isWorking else { return }

        messages.append(ChatMessage(role: .user, text: text))
        draft = ""
        isWorking = true

        Task {
            let answer = await service.reply(to: text)
            messages.append(ChatMessage(role: .assistant, text: answer))
            isWorking = false
        }
    }
}
