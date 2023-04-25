

import Foundation
//for representing a chat message, and checks if its from the current user or not
struct MessageViewModel {
    
    let message: Message

    init(_ message: Message) {
        self.message = message
    }

    var currentUid: String {
        return AuthViewModel.shared.userSession?.uid ?? ""
    }

    var isFromCurrentUser: Bool {
        return message.fromId == currentUid
    }
}
