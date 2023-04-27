
import SwiftUI
// reusable component, for later stage chat channels and more
struct CustomInputView: View {
    @Binding var text: String
    var action: () -> Void

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(Color(.separator))
                .frame(width: UIScreen.main.bounds.width, height: 0.75)

            HStack {
                TextField("Message..", text: $text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .font(.body)
                    .frame(minHeight: 30)

                Button(action: action) {
                    Text("Send")
                        .bold()
                        .foregroundColor(.orange)
                }
            }
            .padding(.bottom, 8)
            .padding(.horizontal)
        }
    }
}
