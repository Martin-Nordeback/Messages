
// TODO: fix deprecated navigationlink with something like "NavigationLink(value: ChatView.self, label: {})"

import SwiftUI
// Main view for all started chats, also where you can create new chats
struct ConversationsView: View {
    // show a new chat
    @State private var showNewMessageView = false
    // show a old chat
    @State private var showChatView = false
    @State var selectedUser: User?
//    ref to the viewModel where the message array and fetching functionality is located
    @ObservedObject var viewModel = ConversationsViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
//                if you select a user to continue chatting with
                if let user = selectedUser {
                    NavigationLink(
                        destination: ChatView(user: user),
                        isActive: $showChatView,
                        label: { })
                }

                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(viewModel.recentMessages) { message in
                            ConversationCell(viewModel: ConversationCellViewModel(message))
                        }
                    }
                }

//                or starting a new chat with someone here
                Button {
                    showNewMessageView.toggle()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .padding()
                }
                .background(.orange)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
                .sheet(isPresented: $showNewMessageView) {
                    NewMessageView(showChatView: $showChatView, user: $selectedUser)
                        // Pass the view model to the new message view
                        .environmentObject(viewModel)
                }
            }
            .onAppear {
                viewModel.fetchRecentMessages()
            }
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
            .preferredColorScheme(.dark)
    }
}
