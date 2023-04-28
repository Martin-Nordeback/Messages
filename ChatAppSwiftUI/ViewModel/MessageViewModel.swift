

import Foundation
// for representing a chat message, and checks if its from the current user or not
struct MessageViewModel {
    let message: Message

    init(_ message: Message) {
        self.message = message
    }

    // computed property returns the ID of the currently logged-in user, or an empty string if the user is not logged in.
    var currentUid: String {
        return AuthViewModel.shared.userSession?.uid ?? ""
    }

    // computed property checks whether the fromId property of the Message object matches the ID of the currently logged-in user.
    var isFromCurrentUser: Bool {
        return message.fromId == currentUid
    }
}
