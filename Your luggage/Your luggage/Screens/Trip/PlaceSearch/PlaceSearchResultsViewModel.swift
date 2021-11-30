//
//  PlaceSearchResultsViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11.11.21.
//

import UIKit
import YourLuggageCore

final class PlacesResultsViewModel: SearchResultsViewModel<PlaceSearchResultCellViewModel> {
    private var places: [PlaceSearchResultCellViewModel] = []
    private let googlePlacesService: GooglePlacesServiceProtocol
    
    init(
        googlePlacesService: GooglePlacesServiceProtocol,
        didSelectPlace: @escaping (PlaceSearchResultCellViewModel) -> Void
    ) {
        self.googlePlacesService = googlePlacesService
        super.init(didSelectResult: didSelectPlace)
    }
    
    override var itemsCount: Int {
        places.count
    }
    
    override func searchResultViewModel(at indexPath: IndexPath) -> PlaceSearchResultCellViewModel {
        places[indexPath.row]
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty
        else {
            return
        }
        googlePlacesService.findPlaces(query: query) { [weak self] result in
            switch result {
            case .failure(let googleError):
                print(googleError.localizedDescription)
            case .success(let resultPlaces):
                self?.places = resultPlaces.map { (place: Place) in
                    PlaceSearchResultCellViewModel(with: place)
                }
                self?.reloadData()
            }
        }
    }
}

// MARK: - PlaceSearchResultCellViewModel

final class PlaceSearchResultCellViewModel {
    var text: String!
    var place: Place!
    
    init(with place: Place) {
        self.text = place.name
        self.place = place
    }
}
