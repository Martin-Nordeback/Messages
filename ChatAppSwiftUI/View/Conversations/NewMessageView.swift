
//TODO: 
//TODO: SearchField
//TODO: Back button when in focus

import SwiftUI

struct NewMessageView: View {
    
    @Binding var showChatView: Bool
    @State private var searchText = ""
    @State private var isEditing = false
    @Environment(\.presentationMode) var mode
    
    
    var body: some View {
        ScrollView {
            
            //Add search bar
            
            
            VStack(alignment: .leading) {
                ForEach(0 ... 10, id: \.self) { _ in
                    Button {
                        showChatView.toggle()
                        mode.wrappedValue.dismiss()
                    } label: {
                        UserCell()
                    }
                }
            }
        }
//        .toolbarTitleMenu {
//            print("going function back here")
//        }
//        .searchable(text: $searchText)
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView(showChatView: .constant(true))
            .preferredColorScheme(.dark)
    }
}
