

import Firebase
import SwiftUI

class NewMessageViewModel: ObservableObject {
    // holds an array of user objects
    @Published var users = [User]()

//     retrieve a list of all the users that can be messaged.
    init() {
        fetchUsers()
    }

    // function queries the Firestore collection COLLECTION_USERS to retrieve all the documents in the collection.
    func fetchUsers() {
        COLLECTION_USERS.getDocuments { snapshot, _ in
            guard let documents = snapshot?.documents else { return }
//            e filter method, as it doesn't make sense for a user to send a message to themselves.
            self.users = documents.compactMap({ try? $0.data(as: User.self) })
                .filter({ $0.id != Auth.auth().currentUser?.uid })
        }
    }
}
