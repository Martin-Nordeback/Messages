
import SwiftUI
// Representing the inside chat where text get display on top of ChatBubbleShaped that changes with the text
struct MessageView: View {
//    the viewModel takes in messages and return to AuthViewModel
    let viewModel: MessageViewModel

    var body: some View {
        HStack {
            if viewModel.isFromCurrentUser {
                Spacer()
                Text(viewModel.message.text)
                    .padding(12)
                    .background(Color.orange)
                    .font(.system(size: 15))
                    .clipShape(ChatBubbleShape(isFromCurrentUser: true))
                    .foregroundColor(.white)
                    .padding(.leading, 100)
                    .padding(.horizontal)

            } else {
                HStack(alignment: .bottom) {
                    Image("dummypic")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())

                    Text(viewModel.message.text)
                        .padding(12)
                        .background(.gray)
                        .font(.system(size: 15))
                        .clipShape(ChatBubbleShape(isFromCurrentUser: false))
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .padding(.trailing, 80)
                Spacer()
            }
        }
    }
}
