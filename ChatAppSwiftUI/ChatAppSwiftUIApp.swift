
import Firebase
import SwiftUI
import CoreData

@main
struct ChatAppSwiftUIApp: App {
    //configure firebase the first time it runs with all necessary infrastructure for other Firebase services to work properly.
    init() {
        FirebaseApp.configure()
    }
//    reference to the singleton, same reason as AuthViewModel
    let persistenceController = CoreDataStack.sharedCoreData
    
    //this return the main view of the app,
    var body: some Scene {
        WindowGroup {
            //this creates only one instance of AuthViewModel
            ContentView().environmentObject(AuthViewModel.shared)
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
        }
    }
}
