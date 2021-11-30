//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/3/21.
//

import Foundation
import CoreData

public protocol TripRepositoryHolderProtocol {
    var tripRepository: TripRepositoryProtocol { get }
}

public protocol TripRepositoryProtocol {
    var viewContext: NSManagedObjectContext { get }
    func tripFetchedResultsController(userID: Any) -> NSFetchedResultsController<Trip>
    func saveTripToStorage(with cityName: String, imageData: Data, longitude: Double, latitude: Double, firstDate: Date, lastDate: Date?, userID: String, tripComplition: @escaping (NSManagedObjectID) -> Void)
}

public class TripRepository: TripRepositoryProtocol {
    lazy public var viewContext: NSManagedObjectContext = {
        self.storage.viewContext
    }()
    public let storage: TripStorageProtocol
    public let tripAPI: TripAPI
    
    public init(storage: TripStorageProtocol, tripAPI: TripAPI) {
        self.storage = storage
        self.tripAPI = tripAPI
    }
    
    public func tripFetchedResultsController(userID: Any) -> NSFetchedResultsController<Trip> {
        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
        
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Trip.firstDate, ascending: false)
        ]
        
        let fetchedResultsController = NSFetchedResultsController<Trip>(
            fetchRequest: fetchRequest,
            managedObjectContext: storage.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("###\(#function): Failed to performFetch: \(error)")
        }
        
        return fetchedResultsController
    }
    
    public func saveTripToStorage(
        with cityName: String,
        imageData: Data,
        longitude: Double,
        latitude: Double,
        firstDate: Date,
        lastDate: Date?,
        userID: String,
        tripComplition: @escaping (NSManagedObjectID) -> Void
    ) {
        self.storage.saveTrip(with: cityName, imageData: imageData, longitude: longitude, latitude: latitude, firstDate: firstDate, lastDate: lastDate, userID: userID, tripComplition: tripComplition)
    }
}

public struct TripRepositoryMock: TripRepositoryProtocol {
    public var viewContext: NSManagedObjectContext
    
    public init() {
        viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    }
    
    public func tripFetchedResultsController(userID: Any) -> NSFetchedResultsController<Trip> {
        fatalError("tripFetchedResultsController(userID:) has not been implemented")
    }
    
    public func saveTripToStorage(with cityName: String, imageData: Data, longitude: Double, latitude: Double, firstDate: Date, lastDate: Date?, userID: String, tripComplition: (NSManagedObjectID) -> Void) {
        fatalError("saveTripToStorage(with:) has not been implemented")
    }
}

