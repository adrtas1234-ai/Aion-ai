import Foundation

protocol AIService {
    func reply(to message: String) async -> String
}

/// Temporary service so the interface can be tested before connecting a model.
/// Replace this with a local model runtime or your own authenticated backend.
struct DemoAIService: AIService {
    func reply(to message: String) async -> String {
        try? await Task.sleep(for: .milliseconds(450))
        return """
        Я получил твоё сообщение: «\(message)»

        Сейчас работает демонстрационный режим интерфейса. Следующий этап — подключить настоящую языковую модель: локальную на iPhone или удалённую через защищённый сервер.
        """
    }
}
