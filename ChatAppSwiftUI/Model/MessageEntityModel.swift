//
//  MessageEntity.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-27.
//
import Foundation
import CoreData


@objc(MessageEntityModel)
public class MessageEntityModel: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    @NSManaged public var fromId: String
    @NSManaged public var toId: String
    @NSManaged public var read: Bool
    @NSManaged public var text: String
    @NSManaged public var timestamp: Date
    @NSManaged public var user: UserEntityModel
    
    
    func fromMessageWithDate(message: Message) {
        id = message.id
        fromId = message.fromId
        toId = message.toId
        read = message.read
        text = message.text
        //timestamp = message.timestamp

        if let user = message.user {
            let userEntity = UserEntityModel(context: managedObjectContext!)
            userEntity.fromUser(user: user)
            self.user = userEntity
        }
    }

}
