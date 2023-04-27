/*
 We need the MessageEntity extension to define the fromMessageWithDate method,
 which is a custom method that we're using to convert Message objects into MessageEntity objects.
 */
import Foundation
extension MessageEntity {
    func fromMessageWithDate(message: Message) {
        self.id = message.id
        self.fromId = message.fromId
        self.toId = message.toId
        self.read = message.read
        self.text = message.text
        self.timestamp = message.timestamp.dateValue()
    }
}
