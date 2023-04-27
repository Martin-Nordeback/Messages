

import FirebaseFirestoreSwift
import Foundation

struct User: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
    let fullname: String
    let email: String
    

}
