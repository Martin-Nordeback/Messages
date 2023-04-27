import CoreData
import Firebase
import Foundation

// allow the class to make changes to the UI
class ChatViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
    // changes to Message will update UI directly
    @Published var messages = [Message]()
    // represent the other user
    let user: User
    private var fetchedResultsController: NSFetchedResultsController<MessageEntityModel>!
    

    init(user: User) {
        self.user = user
        super.init()
        fetchMessagesFromCoreData()
        fetchMessagesFromFirebase()
    }
    
    func fetchMessagesFromCoreData() {
        let context = CoreDataStack.sharedCoreData.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<MessageEntityModel> = MessageEntityModel.fetchRequest()

        // add a sort descriptor to the fetch request to avoid the "sort descriptors missing" error
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MessageEntityModel.timestamp, ascending: true)]

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

    
//    func fetchMessagesFromCoreData() {
//        let context = CoreDataStack.sharedCoreData.persistentContainer.viewContext
//        //let fetchRequest: NSFetchRequest<MessageEntityModel> = MessageEntityModel.fetchRequest() as! NSFetchRequest<MessageEntityModel>
//        let fetchRequest: NSFetchRequest<MessageEntityModel> = MessageEntityModel.fetchRequest()
//        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \MessageEntity.timestamp, ascending: true)]
//
//        fetchedResultsController = NSFetchedResultsController(
//            fetchRequest: fetchRequest,
//            managedObjectContext: context,
//            sectionNameKeyPath: nil,
//            cacheName: nil
//        )
//        fetchedResultsController.delegate = self
//
//        do {
//            try fetchedResultsController.performFetch()
//            //messages = fetchedResultsController.fetchedObjects?.map { Message(messageEntityModel: $0) } ?? []
//
//        } catch {
//            print("Error fetching messages from CoreData: \(error)")
//        }
//    }

    func fetchMessagesFromFirebase() {
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

            // Convert Message to MessageWithDate
            let messagesToSave = messages


            self.saveMessagesToCoreData(messages: messagesToSave)
            self.messages.append(contentsOf: messages)
        }
    }

    
    func saveMessagesToCoreData(messages: [Message]) {
        let context = CoreDataStack.sharedCoreData.persistentContainer.viewContext
        for message in messages {
            let messageEntity = MessageEntityModel(context: context)
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
        currentUserRef.setData(data)
        chatPartnerRef.document(messageId).setData(data)
        recentCurrentRef.setData(data)
        recentPartnerRef.setData(data)

//        if let message = try? Message(from: data) {
//            message.user = user
//            saveMessagesToCoreData(messages: [message])
//        }
    }
}
