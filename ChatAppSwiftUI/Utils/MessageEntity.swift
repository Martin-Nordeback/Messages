//
//  MessageEntity.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-27.
//

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
