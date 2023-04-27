
import Firebase
import FirebaseFirestoreSwift

// message model, for both firebase and coredata
struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp

    var user: User?
    
    init(from data: [String: Any]) {
        id = data["id"] as? String
        text = data["text"] as? String ?? ""
        fromId = data["fromId"] as? String ?? ""
        toId = data["toId"] as? String ?? ""
        timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        read = data["read"] as? Bool ?? false
        user = nil
    }

    init(messageEntity: MessageEntity) {
        id = messageEntity.id
        text = messageEntity.text ?? ""
        fromId = messageEntity.fromId ?? ""
        toId = messageEntity.toId ?? ""
        timestamp = Timestamp(date: messageEntity.timestamp ?? Date())
        read = messageEntity.read
        user = nil
    }

    enum CodingKeys: String, CodingKey {
        case id
        case fromId
        case toId
        case read
        case text
        case timestamp
    }
}

