
// TODO: fix deprecated navigationlink with something like "NavigationLink(value: ChatView.self, label: {})"


import SwiftUI
//Main view for all started chats, also where you can create new chats
struct ConversationsView: View {
    @State private var showNewMessageView = false
    @State private var showChatView = false
    //rep the user for chat
    @State var selectedUser: User?
    @ObservedObject var viewModel = ConversationsViewModel()

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if let user = selectedUser {
                NavigationLink(
                    destination: ChatView(user: user),
                    isActive: $showChatView,
                    label: { })
            }
            ScrollView {
                VStack {
                    ForEach(viewModel.recentMessages) { message in
                        ConversationCell(viewModel: ConversationCellViewModel(message))
                    }
                }
            }

            Button {
                showNewMessageView.toggle()
            } label: {
                Image(systemName: "pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding()
            }
            .background(.orange)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            .sheet(isPresented: $showNewMessageView, content: {
                NewMessageView(showChatView: $showChatView, user: $selectedUser)
            })
        }
        .onAppear {
            viewModel.fetchRecentMessages()
        }
    }
}

struct ConversationsView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationsView()
            .preferredColorScheme(.dark)
    }
}
