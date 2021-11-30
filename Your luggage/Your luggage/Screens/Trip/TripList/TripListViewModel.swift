//
//  TripViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/1/21.
//

import UIKit
import UIComponents
import YourLuggageCore
import CoreData
import FirebaseDatabase

protocol TripListViewModelProtocol: AnyObject {
    var accountNavigationBarButton: ButtonViewModelProtocol { get }
    var header: String { get }
    var headerSubTitle: String { get }
    var title: LabelViewModelProtocol { get }
    var addTripButton: ButtonViewModelProtocol { get }
    var itemsCount: Int { get }
    func numberOfRowsInSection(_ section: Int) -> Int
    func tripCellViewModel(at indexPath: IndexPath) -> TripCellViewModel
}

final class TripListViewModel: NSObject, TripListViewModelProtocol {
    
    var itemsCount: Int {
        return fetchResultController.sections?.count ?? 0
    }
    
    lazy var accountNavigationBarButton: ButtonViewModelProtocol = ButtonViewModel(
        text: nil,
        image: UIImage(systemName: "person.fill"),
        style: .rounded,
        borderWidth: 3,
        borderColor: .limeGreen,
        tintColor: .fireOrange) {
        // action when tap accountNavigationBarButton
    }
    var header: String = "Welcome,"
    
    var headerSubTitle: String {
        self.userRepository.userName ?? ""
    }
    
    var title: LabelViewModelProtocol = LabelViewModel(
        text: "Add your first trip!",
        typography: .tripsMainTitle
    )
    
    lazy var addTripButton: ButtonViewModelProtocol = ButtonViewModel(
        text: nil,
        image: UIImage(systemName: "plus",
                       withConfiguration: UIImage.SymbolConfiguration(pointSize: 140, weight: .semibold, scale: .large)),
        style: .rounded,
        backgroundColor: .limeGreen,
        borderWidth: 3,
        borderColor: .forestGreen,
        tintColor: .fireOrange,
        action: { [weak self] in
            self?.router.addTrip()
        }
    )
    
    private let router: TripList.Router
    private let tripRepository: TripRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let fetchResultController: NSFetchedResultsController<Trip>
    private let userID: String
    
    init(router: TripList.Router,
         tripRepository: TripRepositoryProtocol,
         userRepository: UserRepositoryProtocol,
         userID: String
    ) {
        self.router = router
        self.tripRepository = tripRepository
        self.userRepository = userRepository
        self.userID = userID
        fetchResultController = tripRepository.tripFetchedResultsController(userID: userID)
        print("UserID in TripListViewModel: \(userID)")
    }
}

extension TripListViewModel {
    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let sections = fetchResultController.fetchedObjects else { return 0 }
        return sections.count
    }
    
    func tripCellViewModel(at indexPath: IndexPath) -> TripCellViewModel {
        let trip = fetchResultController.object(at: indexPath)
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "d MMM yyyy"
        var stringDate = ""
        if let date = trip.firstDate {
            stringDate = dateFormatterGet.string(from: date)
        }
        if let date = trip.lastDate {
            stringDate += " - \(dateFormatterGet.string(from: date))"
        }
        return TripCellViewModel(city: trip.cityName, date: stringDate, imageData: trip.image)
    }
}
