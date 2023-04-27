
import CoreData

// This class is a singleton class, the sharedCoreData make sure of that
class CoreDataStack {
    static let sharedCoreData = CoreDataStack()

//     This prevents the creation of additional instances of the CoreDataStack class from outside the class itself.
    private init() {}

//    ini
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChatAppModel")

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }

        return container

    }()

//    saves changes to the coredata
    func saveContext() {
        let context = persistentContainer.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
