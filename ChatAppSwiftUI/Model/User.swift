//
//  User.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-25.
//

import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    

}
