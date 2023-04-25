
import Firebase
import Foundation

//allow the class to make changes to the UI
class ChatViewModel: ObservableObject {
    //changes to Message will update UI directly
    @Published var messages = [Message]()
    //represent the other user
    let user: User

    init(user: User) {
        self.user = user
        fetchMessages()
    }

    func fetchMessages() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }

        let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)

        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }

            var messages = changes.compactMap { try? $0.document.data(as: Message.self) }

            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = self.user
            }

            self.messages.append(contentsOf: messages)
        }
    }

    func sendMessage(_ messageText: String) {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }

        let currentUserRef = COLLECTION_MESSAGES.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection(currentUid)

        let recentCurrentRef = COLLECTION_MESSAGES.document(currentUid).collection("recent-messages")
            .document(chatPartnerId)
        let recentPartnerRef = COLLECTION_MESSAGES.document(chatPartnerId).collection("recent-messages")
            .document(currentUid)

        let messageId = currentUserRef.documentID

        let data: [String: Any] = ["text": messageText,
                                   "fromId": currentUid,
                                   "toId": chatPartnerId,
                                   "read": false,
                                   "timestamp": Timestamp(date: Date())
        ]
        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)
    }
}


