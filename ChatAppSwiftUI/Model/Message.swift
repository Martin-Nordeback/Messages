
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
    /* This init takes a dictionary of String keys and Any values, then sets the properties of the Message struct using the dictionary values.
     If any values are missing or of the wrong type, the properties are set to default values. */
    init(from data: [String: Any]) {
        id = data["id"] as? String
        text = data["text"] as? String ?? ""
        fromId = data["fromId"] as? String ?? ""
        toId = data["toId"] as? String ?? ""
        timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        read = data["read"] as? Bool ?? false
        user = nil
    }

    // same as above but for coredata
    init(messageEntity: MessageEntity) {
        id = messageEntity.id
        text = messageEntity.text ?? ""
        fromId = messageEntity.fromId ?? ""
        toId = messageEntity.toId ?? ""
        timestamp = Timestamp(date: messageEntity.timestamp ?? Date())
        read = messageEntity.read
        user = nil
    }

    // Without the CodingKeys, Swift would not know which properties to encode or decode and what keys to use in the encoded data.
    enum CodingKeys: String, CodingKey {
        case id
        case fromId
        case toId
        case read
        case text
        case timestamp
    }
}
