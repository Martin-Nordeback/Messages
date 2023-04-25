

import Firebase

class AuthViewModel: NSObject, ObservableObject {
    @Published var didAuthenticateUser = false
    //rep the current users state
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?

    //Stores users temporary after the got created
    private var tempCurrentUser: FirebaseAuth.User?

    //their is only 1 instance of this class
    static let shared = AuthViewModel()

    //init the userSession, with the current user
    override init() {
        super.init()
        userSession = Auth.auth().currentUser
        fetchUser()
    }

    //login in user, with email and password,
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to signin with \(error.localizedDescription)")
                return
            }

            //if successful, update the user session and fetching the data from the user
            guard (result?.user) != nil else { return }
            self.userSession = result?.user
            self.fetchUser()
        }
    }

    // we need to get the information from the view from the user, register to firebase
    func register(withEmail email: String, password: String, fullname: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with \(error.localizedDescription)")
                return
            }
//            print("DEBUG: Successfully register ")
            guard let user = result?.user else { return }
            self.tempCurrentUser = user

            let data: [String: Any] = ["email": email,
                                       "username": username,
                                       "fullname": fullname]

            COLLECTION_USERS.document(user.uid).setData(data) { _ in
//                self.userSession = result?.user
//                self.fetchUser()
                self.didAuthenticateUser = true
            }
        }
    }

    func uploadProfileImage(_ image: UIImage) {
        print("DEBUG: Successfully User updated picture from viewModel")
    }

    func signout() {
        userSession = nil
        try? Auth.auth().signOut()
    }

    func fetchUser() {
        guard let uid = userSession?.uid else { return }

        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            self.currentUser = user
//            print("DEBUG: User object is \(user)")
        }
    }
}
