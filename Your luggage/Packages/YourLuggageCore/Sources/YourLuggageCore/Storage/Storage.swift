import CoreData

public protocol TripStorageProtocol {
    var viewContext: NSManagedObjectContext { get }
    func saveTrip(
        with cityName: String,
        imageData: Data,
        longitude: Double,
        latitude: Double,
        firstDate: Date,
        lastDate: Date?,
        userID: String,
        tripComplition: @escaping (NSManagedObjectID) -> Void
    )
}

public protocol UserStorageProtocol {
    func saveUser(with userID: String)
}

public final class Storage: TripStorageProtocol, UserStorageProtocol {
    public var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    public var backgroundContext: NSManagedObjectContext {
        let context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    private let persistentContainer: NSPersistentContainer
    
    public init() {
        let modelURL = Bundle.module.url(forResource: "Your_luggage", withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        persistentContainer = NSPersistentContainer(name: "Your_luggage", managedObjectModel: model!)
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Core Data Saving support
    
    public func saveTrip(
        with cityName: String,
        imageData: Data,
        longitude: Double,
        latitude: Double,
        firstDate: Date,
        lastDate: Date?,
        userID: String,
        tripComplition: @escaping (NSManagedObjectID) -> Void
    ) {
        let context = backgroundContext
        context.perform { [weak context] in
            guard let context = context else { return }
            let user = self.fetchUser(with: userID, context: context)
            guard let userU = user else { return }
            let trip = Trip.insert(in: context)
            trip.cityName = cityName
            trip.longitude = longitude
            trip.latitude = latitude
            trip.image = imageData
            trip.firstDate = firstDate
            trip.lastDate = lastDate
            trip.user = userU
            context.saveIfNeeded()
            tripComplition(trip.objectID)
        }
    }
    
    public func saveUser(with userID: String) {
        // TODO: да ладно, але, func saveTrip(...) ты же писал там на бэкграйнде зачЭм тут такое?!
        let context = backgroundContext
        let user = User.insert(in: context)
        user.userID = userID
        print("User before saving: \(user)")
        context.saveIfNeeded()
    }
    
    private func fetchUser(with userID: String, context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(
            format: "%K = %@",
            #keyPath(User.userID), userID
        )

        do {
            return try User.find(predicate: predicate, in: context)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

extension NSManagedObjectContext {
    func saveIfNeeded() {
        guard hasChanges else {
            return
        }
        
        do {
            try save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

extension NSManagedObject {
    static func insert(in context: NSManagedObjectContext) -> Self {
        NSEntityDescription.insertNewObject(forEntityName: String(describing: self), into: context) as! Self
    }

    class func find(predicate: NSPredicate, in context: NSManagedObjectContext) throws -> Self {
        let request = fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1

        let fetchResult = try context.fetch(request)
        guard let result = fetchResult.first as? Self else {
            throw StorageError.notFound
        }

        return result
    }
}
