
// TODO:
// TODO:
// Inside a uniq chat

import SwiftUI

struct ChatView: View {
    @State private var messageText = ""
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach(0 ... 10, id: \.self) { _ in
                        MessageView(isFromCurrentUser: true, messageText: "Hello my name is Martin")
                    }
                }
            }
            VStack {
                Rectangle()
                    .foregroundColor(Color(.separator))
                    .frame(width: UIScreen.main.bounds.width, height: 0.75)

                HStack {
                    TextField("Message..", text: $messageText)
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.body)
                        .frame(minHeight: 30)

                    Button {
                        sendMessage()
                    } label: {
                        Text("Send")
                            .bold()
                            .foregroundColor(.orange)
                    }
                }
                .padding(.bottom, 8)
                .padding(.horizontal)
                
            }
        }
        .navigationTitle("Name")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.bottom)
    }

    func sendMessage() {
        print("Send message \(messageText)")
        messageText = ""
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
            .preferredColorScheme(.dark)
    }
}
