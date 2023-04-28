

import Foundation

class ConversationCellViewModel: ObservableObject {
//    @Published var user: User?
    @Published var message: Message

    init(_ message: Message) {
        self.message = message
        fetchUser()
    }

    // computed property checking if the fromId property of the message matches the ID of the currently logged-in user.
    var chatPartnerId: String {
        return message.fromId == AuthViewModel.shared.userSession?.uid ? message.toId : message.fromId
    }

    // computed property returns the full name of the chat partner user
    var fullname: String {
        guard let user = message.user else { return "" }
        return user.fullname
    }

    /*function queries the Firestore collection COLLECTION_USERS to retrieve the user document with an ID matching the chat partner ID.
     also update is published to any SwiftUI views that are observing the message property, which can be used to update the user interface.*/
    func fetchUser() {
        COLLECTION_USERS.document(chatPartnerId).getDocument { snapshot, _ in
            self.message.user = try? snapshot?.data(as: User.self)
        }
    }
}
