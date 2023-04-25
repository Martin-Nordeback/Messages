//
//  Constants.swift
//  ChatAppSwiftUI
//
//  Created by Martin Nordebäck on 2023-04-13.
//

import Foundation
import Firebase
// MARK: for text values
let HELLO: String = "Hello"

// MARK: For firebase
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
