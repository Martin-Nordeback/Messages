//
//  UserEntity.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-27.
//

import CoreData

@objc(UserEntityModel)
public class UserEntityModel: NSManagedObject, Identifiable {
    @NSManaged public var id: String?
    @NSManaged public var username: String
    @NSManaged public var fullname: String
    @NSManaged public var email: String
    @NSManaged public var messages: Set<MessageEntityModel>
}
