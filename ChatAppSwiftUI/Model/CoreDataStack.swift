
import CoreData

// This class is a singleton class, the sharedCoreData make sure of that
class CoreDataStack {
    static let sharedCoreData = CoreDataStack()

    
    //This prevents the creation of additional instances of the CoreDataStack class from outside the class itself.
    private init() {}

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatAppModel")
        print("COREDATASTACK RAD 1")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
        }
        print("COREDATASTACK RAD 2")
        return container
        
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        print("COREDATASTACK RAD 3")
        if context.hasChanges {
            print("COREDATASTACK RAD 4")
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
