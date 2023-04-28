
// TODO: When starting a new chat you should get straigt in to that
// TODO: SearchField functionality
// TODO:

import SwiftUI

struct NewMessageView: View {
    @Binding var showChatView: Bool
    @Environment(\.presentationMode) var mode
    @State private var searchText = ""
    @State private var isEditing = false
    @Binding var user: User?
    @ObservedObject var viewModel = NewMessageViewModel()

    var body: some View {
        ScrollView {
            SearchBar(text: $searchText, isEditing: $isEditing)
                .onTapGesture {
                    isEditing.toggle()
                }
                .padding()

            VStack(alignment: .leading) {
                ForEach(viewModel.users) { user in
                    Button {
                        showChatView.toggle()
                        self.user = user
                        mode.wrappedValue.dismiss()
                        print("Selected user: \(user.username), showChatView: \(showChatView)")
                    } label: {
                        UserCell(user: user)
                    }
                }
            }
            .padding(.top)
        }
        .onAppear {
//            calls the object, which retrieves the list of users from Firestore.
            viewModel.fetchUsers()
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(showChatView: .constant(false), user: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
