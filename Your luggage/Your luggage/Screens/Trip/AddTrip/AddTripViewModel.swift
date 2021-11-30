//
//  AddTripViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/8/21.
//

import UIKit
import UIComponents
import YourLuggageCore
import CoreData
import FSCalendar
import GooglePlaces

protocol AddTripViewModelProtocol: AnyObject {
    var backButton: ButtonViewModelProtocol { get }
    var placeSearchViewModel: PlaceSearchViewModelProtocol { get }
    var titleLabel: LabelViewModelProtocol { get }
    var travelButton: ButtonViewModelProtocol { get }
    var businessButton: ButtonViewModelProtocol { get }
    var addTripButton: ButtonViewModelProtocol { get }
    var getDates: ((Date, Date?) -> Void) { get set }
}

final class AddTripViewModel: AddTripViewModelProtocol {
    
    lazy var googlePlacesService: GooglePlacesServiceProtocol = {
        let apiKey = self.configRepository.appConfig.googlePlacesAPIKey
        GMSPlacesClient.provideAPIKey(apiKey)
        let client = GMSPlacesClient.shared()
        return GooglePlacesService(client: client)
    }()
    
    lazy var backButton: ButtonViewModelProtocol = ButtonViewModel(
        text: nil,
        image: UIImage(systemName: "chevron.left"),
        style: .rounded,
        borderWidth: 3,
        borderColor: .limeGreen,
        tintColor: .fireOrange,
        action: { [weak self] in
            self?.router.tripList()
        }
    )
    
    lazy var placeSearchViewModel: PlaceSearchViewModelProtocol = PlaceSearchViewModel(
        configRepository: configRepository,
        searchResult: { [weak self] cellViewModel in
            self?.addTrip(using: cellViewModel)
        }
    )
    
    let titleLabel: LabelViewModelProtocol = LabelViewModel(text: "Travel format", typography: .addTripTitle)
    
    let travelButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Travel",
        style: .rect,
        borderWidth: 1,
        borderColor: .limeGreen,
        tintColor: nil,
        action: {
            // change buttonState
        }
    )
    
    let businessButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Business",
        style: .rect,
        borderWidth: 1,
        borderColor: .limeGreen,
        tintColor: nil,
        action: {
            // change buttonState
        }
    ) 
    
    lazy var addTripButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Add trip",
        style: .rect,
        backgroundColor: .fireOrange,
        borderWidth: 1,
        borderColor: .limeGreen,
        tintColor: nil,
        action: { [weak self] in
            
            guard let self = self,
                  let cityImage = self.placeImageData,
                  let cityName = self.cityName,
                  let longitude = self.placeCoordinates?.longitude,
                  let latitude = self.placeCoordinates?.latitude,
                  let firstDate = self.firstDate,
                  let userID = self.userRepository.userID
                  else {
                    return
                  }
            self.tripRepository.saveTripToStorage(
                with: cityName,
                imageData: cityImage,
                longitude: longitude,
                latitude: latitude,
                firstDate: firstDate,
                lastDate: self.lastDate,
                userID: userID,
                tripComplition: { [weak self] id in
                    print("TripID in AddTripViewModel: \(id)")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        // show activity indicator and hide all UI
                        self?.router.trip()
                    }
                }
            )
        }
    )
    
    private let router: AddTrip.Router
    private let tripRepository: TripRepositoryProtocol
    private let userRepository: UserRepositoryProtocol
    private let configRepository: ConfigRepositoryProtocol
    private var placeCoordinates: CLLocationCoordinate2D?
    private var placeImageData: Data?
    private var firstDate: Date?
    private var lastDate: Date?
    private var cityName: String?
    
    var getDates: ((Date, Date?) -> Void) = { _,_ in }
    
    init(router: AddTrip.Router,
         tripRepository: TripRepositoryProtocol,
         userRepository: UserRepositoryProtocol,
         configRepository: ConfigRepositoryProtocol) {
        self.router = router
        self.tripRepository = tripRepository
        self.userRepository = userRepository
        self.configRepository = configRepository
        self.getDates = { [weak self] firstDate, lastDate in
            self?.firstDate = firstDate
            self?.lastDate = lastDate
        }
    }
    
    private func addTrip(using place: PlaceSearchResultCellViewModel) {
        self.placeSearchViewModel.getPlace = { [weak self] (place: Place) in
            self?.cityName = place.name
            self?.googlePlacesService.getLocation(for: place) { result in
                switch result {
                case .failure(let googleError):
                    print(googleError.localizedDescription)
                case .success(let coordinates):
                    print(coordinates)
                    self?.placeCoordinates = coordinates
                    
                }
            }
            
            self?.googlePlacesService.getImage(for: place) { result in
                switch result {
                case .failure(let googleError):
                    print(googleError.localizedDescription)
                case .success(let image):
                    self?.placeImageData = image.pngData()
                }
            }
        }
    }
}
