//
//  PlaceSearchViewModel.swift
//  Your luggage
//
//  Created by Igor Bachek on 11.11.21.
//

import YourLuggageCore
import GooglePlaces

protocol PlaceSearchViewModelProtocol {
    var searchResult: (PlaceSearchResultCellViewModel) -> Void { get }
    var searchResultsViewModel: PlacesResultsViewModel { get }
    var searchEnded: (String) -> Void { get set }
    var getPlace: (Place) -> Void { get set }
}

final class PlaceSearchViewModel: PlaceSearchViewModelProtocol {
    var searchEnded: (String) -> Void = { _ in }
    var getPlace: (Place) -> Void = { _ in }
    
    var searchResult: (PlaceSearchResultCellViewModel) -> Void
    private let googlePlacesService: GooglePlacesService
    lazy var searchResultsViewModel: PlacesResultsViewModel = {
        let searchResultsViewModel = PlacesResultsViewModel(
            googlePlacesService: googlePlacesService,
            didSelectPlace: { [weak self] (result: PlaceSearchResultCellViewModel) in
                self?.searchResult(result)
                self?.searchEnded(result.text)
                self?.getPlace(result.place)
            }
        )
        
        return searchResultsViewModel
    }()
    
    init(
        configRepository: ConfigRepositoryProtocol,
        searchResult: @escaping (PlaceSearchResultCellViewModel) -> Void
    ) {
        self.searchResult = searchResult
        let apiKey = configRepository.appConfig.googlePlacesAPIKey
        GMSPlacesClient.provideAPIKey(apiKey)
        let client = GMSPlacesClient.shared()
        googlePlacesService = GooglePlacesService(client: client)
    }
}
