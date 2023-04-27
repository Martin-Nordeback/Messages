
import Firebase
import FirebaseFirestoreSwift

// message model, check firebase
struct Message: Identifiable, Decodable {
    @DocumentID var id: String?
    let fromId: String
    let toId: String
    let read: Bool
    let text: String
    let timestamp: Timestamp

    var user: User?

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

//import Firebase
//import FirebaseFirestoreSwift
//import CoreData
//
//// message model, check firebase
//struct Message: Identifiable, Decodable {
//    @DocumentID var id: String?
//    let fromId: String
//    let toId: String
//    let read: Bool
//    let text: String
//    let timestamp: Timestamp
//
//    var user: User?
//
//    init(messageEntity: MessageEntity) {
//        id = messageEntity.id
//        text = messageEntity.text ?? ""
//        fromId = messageEntity.fromId ?? ""
//        toId = messageEntity.toId ?? ""
//        timestamp = Timestamp(date: messageEntity.timestamp ?? Date())
//        read = messageEntity.read
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(String.self, forKey: .id)
//        fromId = try container.decode(String.self, forKey: .fromId)
//        toId = try container.decode(String.self, forKey: .toId)
//        read = try container.decode(Bool.self, forKey: .read)
//        text = try container.decode(String.self, forKey: .text)
//        let timestampValue = try container.decode(Timestamp.self, forKey: .timestamp)
//        timestamp = timestampValue.dateValue()
//        user = nil
//    }
//
//}
//
//struct MessageWithDate {
//    var id: String?
//    let fromId: String
//    let toId: String
//    let read: Bool
//    let text: String
//    let timestamp: Date
//
//    var user: User?
//}
