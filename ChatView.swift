import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        LazyVStack(spacing: 14) {
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }

                            if viewModel.isWorking {
                                HStack {
                                    ProgressView()
                                    Text("AION думает…")
                                        .font(.footnote)
                                        .foregroundStyle(.secondary)
                                    Spacer()
                                }
                                .padding(.horizontal)
                            }
                        }
                        .padding(.horizontal, 14)
                        .padding(.vertical, 18)
                    }
                    .onChange(of: viewModel.messages.count) {
                        guard let last = viewModel.messages.last else { return }
                        withAnimation(.easeOut(duration: 0.2)) {
                            proxy.scrollTo(last.id, anchor: .bottom)
                        }
                    }
                }

                composer
            }
            .background(Color(red: 0.055, green: 0.055, blue: 0.065))
            .navigationTitle("AION")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                    .tint(.white)
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
                    .presentationDetents([.medium, .large])
            }
        }
        .tint(.white)
    }

    private var composer: some View {
        HStack(alignment: .bottom, spacing: 10) {
            TextField("Напиши AION…", text: $viewModel.draft, axis: .vertical)
                .lineLimit(1...5)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .background(Color.white.opacity(0.09))
                .clipShape(RoundedRectangle(cornerRadius: 22))

            Button(action: viewModel.send) {
                Image(systemName: "arrow.up")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundStyle(.black)
                    .frame(width: 44, height: 44)
                    .background(Color.white)
                    .clipShape(Circle())
            }
            .disabled(viewModel.draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isWorking)
            .opacity(viewModel.draft.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.45 : 1)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 10)
        .background(.ultraThinMaterial)
    }
}

private struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack {
            if message.role == .assistant {
                bubble
                Spacer(minLength: 36)
            } else {
                Spacer(minLength: 36)
                bubble
            }
        }
    }

    private var bubble: some View {
        Text(message.text)
            .font(.system(size: 16))
            .foregroundStyle(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(message.role == .user ? Color.white.opacity(0.17) : Color.white.opacity(0.075))
            .clipShape(RoundedRectangle(cornerRadius: 19))
            .textSelection(.enabled)
    }
}
