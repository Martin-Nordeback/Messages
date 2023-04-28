
// TODO: When starting a new chat you should get straigt in to that
// TODO: SearchField
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
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    SearchBar(text: $searchText, isEditing: $isEditing)

                    ForEach(viewModel.users) { user in
                        Button(action: {
                            showChatView.toggle()
                            self.user = user
                            mode.wrappedValue.dismiss()
                        }, label: {
                            UserCell(user: user)
                        })
                    }
                }
                .padding(.top)
            }
            .onAppear {
                viewModel.fetchUsers()
            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {
                mode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(showChatView: .constant(false), user: .constant(nil))
            .preferredColorScheme(.dark)
    }
}
