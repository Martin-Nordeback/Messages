
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
        NavigationStack {
            ScrollView {
                // Add search bar

                VStack(alignment: .leading) {
                    ForEach(viewModel.users) { user in
                        Button {
                            showChatView.toggle()
                            self.user = user
                            mode.wrappedValue.dismiss()
                        } label: {
                            UserCell(user: user)
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText)
    }
}

