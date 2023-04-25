
// TODO: Generate a profile picture
// TODO:

import SwiftUI

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

                            Text(viewModel.message.text)
                                .font(.system(size: 14))
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

// struct ConversationCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationCell()
//            .preferredColorScheme(.dark)
//    }
// }
