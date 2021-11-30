////
////  TripListDataProvider.swift
////  Your luggage
////
////  Created by Vitaly Nabarouski on 11/1/21.
////
//
//import CoreData
//import YourLuggageCore
//
//protocol TripListDataProviderDelegate {
//    // TODO: сюда переписать все функции делегата NSFetchedResultsController которые будешь использовать в ViewController
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>)
//}
//
//protocol TripListDataProviderProtocol {
//    // TODO: методы доступа
//    // rowsCount
//    // objectAtIndexPath
//}
//
//final class TripListDataProvider: NSObject, TripListDataProviderProtocol, NSFetchedResultsControllerDelegate {
//    private let tripRepository: TripRepositoryProtocol
//    //    private let userRepository: UserRepositoryProtocol
//    private let fetchedResultsController: NSFetchedResultsController<Trip>
//    
//    init(tripRepository: TripRepositoryProtocol) {
//        self.tripRepository = tripRepository
//        
//        let fetchRequest: NSFetchRequest<Trip> = Trip.fetchRequest()
//        //        fetchRequest.predicate = NSPredicate(
//        //            format: "%K == %@",
//        //            argumentArray: [
//        //                #keyPath(User.userID), tripRepository.userID,
//        //            ]
//        //        )
//        
//        fetchRequest.sortDescriptors = [
//            NSSortDescriptor(keyPath: \Trip.firstDate, ascending: false),
//        ]
//        
//        fetchedResultsController = NSFetchedResultsController<Trip>(
//            fetchRequest: fetchRequest,
//            managedObjectContext: tripRepository.viewContext,
//            sectionNameKeyPath: nil,
//            cacheName: nil
//        )
//        
//        super.init()
//        fetchedResultsController.delegate = self
//        
//        do {
//            try fetchedResultsController.performFetch()
//        } catch {
//            fatalError("###\(#function): Failed to performFetch: \(error)")
//        }
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("ControllerDidChange")
//    }
//    
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        print("ControllerWillChange")
//    }
//}
