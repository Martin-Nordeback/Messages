
import Combine
import Firebase
import SwiftUI

class ConversationsViewModel: ObservableObject {
    
    //holds an array of message objects
    @Published var recentMessages = [Message]()

    //gets the latest messages from firebase
    init() {
        fetchRecentMessages()
    }

    //gets the currently logged in user uniq id
    func fetchRecentMessages() {
        guard let uid = AuthViewModel.shared.userSession?.uid else { return }
        //query sorts the messages by their timestamp in descending order
        let query = COLLECTION_MESSAGES.document(uid)
            .collection("recent-messages")
            .order(by: "timestamp", descending: true)

        //listen for changes to the collection in real-time
        query.addSnapshotListener { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
            self.recentMessages = documents.compactMap({ try? $0.data(as: Message.self) })
        }
    }
}
