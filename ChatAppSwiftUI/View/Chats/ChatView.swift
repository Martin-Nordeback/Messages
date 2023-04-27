
import SwiftUI
// all the view under this folder is combined to display the inside chat conversation
struct ChatView: View {
    @State private var messageText = ""
    @ObservedObject var viewModel: ChatViewModel
    private let user: User

    init(user: User) {
        self.user = user
        viewModel = ChatViewModel(user: user)
    }

    var body: some View {
        VStack {
            // messages
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.messages) { message in
                        MessageView(viewModel: MessageViewModel(message))
                    }
                }
            }

            CustomInputView(text: $messageText, action: sendMessage)
        }
        .navigationTitle(user.username)
        .navigationBarTitleDisplayMode(.inline)
        .padding(.vertical)
    }
// sending message to the chatView model and clearing the inputField
    func sendMessage() {
        viewModel.sendMessage(messageText)
        messageText = ""
    }
}
