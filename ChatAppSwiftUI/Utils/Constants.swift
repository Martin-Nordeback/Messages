

import Foundation
import Firebase
// MARK: for text values
let HELLO: String = "Hello,"
let WELCOME: String = "Welcome back!"

// MARK: For firebase
let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
