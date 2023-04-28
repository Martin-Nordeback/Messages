
// TODO: Generate a profile picture
// TODO:

import SwiftUI
//this is where the user get displayed in the ConversationView, with their name and the lates message
struct ConversationCell: View {
    @ObservedObject var viewModel: ConversationCellViewModel

    var body: some View {
        if let user = viewModel.message.user {
            NavigationLink(destination: ChatView(user: user)) {
                VStack {
                    HStack {
                        // change default picutre
                        Image("dummypic")

                        // Message info
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.fullname)
                                .font(.system(size: 14, weight: .semibold))

//                            max 1 line to not take to much space from other users inside ConversationView
                            Text(viewModel.message.text)
                                .font(.system(size: 14))
                                .lineLimit(1)
                        }
                        .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal)
                    Divider()
                }
                .padding(.top)
            }
        }
    }
}
