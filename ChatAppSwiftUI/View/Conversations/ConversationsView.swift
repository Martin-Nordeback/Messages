
// TODO: fix deprecated navigationlink with something like "NavigationLink(value: ChatView.self, label: {})"
// TODO: Back button inside newchat view

import SwiftUI

struct ConversationsView: View {
    @State private var showNewMessageView = false
    @State private var showChatView = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                // chats
                NavigationLink(destination: ChatView(), isActive: $showChatView) {}

                ScrollView {
                    VStack {
                        ForEach(0 ... 10, id: \.self) { _ in
                            NavigationLink(destination: ChatView()) {
                                ConversationCell()
                            }
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
                .fullScreenCover(isPresented: $showNewMessageView) {
                    NewMessageView(showChatView: $showChatView)
//                        .navigationBarBackButtonHidden(true)
//                        .navigationBarItems(leading: Button(action: {
//                            presentationMode.wrappedValue.dismiss()
//                        }, label: {
//                            Image(systemName: "chevron.left")
//                            Text("Go Back")
//                        }))
                }
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
