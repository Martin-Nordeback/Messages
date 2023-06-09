import CoreData
import Firebase
import Foundation

// ChatViewModel class that handles the business logic for a chat view, fetching messages from either Core Data or Firebase, and sending new messages.
class ChatViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    // changes to Message will update UI directly
    @Published var messages = [Message]()
    // represent the other user
    let user: User
    private var fetchedResultsController: NSFetchedResultsController<MessageEntity>!

    init(user: User) {
        self.user = user
        super.init()
        fetchMessagesFromFirebase()
    }

    // MARK: FETCHMESSAGESFROMCOREDATA

    func fetchMessagesFromCoreData() {
//         NSFetchRequest to retrieve messages from Core Data
        let context = CoreDataStack.sharedCoreData.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MessageEntity> = MessageEntity.fetchRequest()

        // add a sort descriptor to the fetch request to avoid the "sort descriptors missing" error
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MessageEntity.timestamp, ascending: true)]

        fetchedResultsController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultsController.delegate = self

        do {
            try fetchedResultsController.performFetch()
            messages = fetchedResultsController.fetchedObjects?.map { Message(messageEntity: $0) } ?? []
        } catch {
            print("Error fetching messages from CoreData: \(error)")
        }
    }

    // MARK: FETCHMESSAGESFROMFIREBASE

    func fetchMessagesFromFirebase() {
        guard let currentUid = AuthViewModel.shared.userSession?.uid else { return }
        guard let chatPartnerId = user.id else { return }
        // retrieve messages from the chat partner user
        let query = COLLECTION_MESSAGES
            .document(currentUid)
            .collection(chatPartnerId)
            .order(by: "timestamp", descending: false)

        // listens for changes to the data in real-time. When changes occur, the function filters the changes to only include added
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges, !changes.isEmpty else {
                self.fetchMessagesFromCoreData()
                return
            }
            let addedChanges = changes.filter { $0.type == .added }
            guard !addedChanges.isEmpty else { return }

            var messages = addedChanges.compactMap { try? $0.document.data(as: Message.self) }

            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = self.user
            }

            // Convert Message to MessageWithDate
            let messagesToSave = messages
            // saves the messages to Core Data, and appends the messages to the messages property.
            self.saveMessagesToCoreData(messages: messagesToSave)
            self.messages.append(contentsOf: messages)
        }
    }

    func saveMessagesToCoreData(messages: [Message]) {
        let context = CoreDataStack.sharedCoreData.persistentContainer.viewContext
        for message in messages {
            let messageEntity = MessageEntity(context: context)
            messageEntity.fromMessageWithDate(message: message)
        }
        CoreDataStack.sharedCoreData.saveContext()
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
                                   "timestamp": Timestamp(date: Date()),
                                   "id": messageId,
        ]

        var message = Message(from: data)
        message.user = user
        saveMessagesToCoreData(messages: [message])

        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)
    }
}
