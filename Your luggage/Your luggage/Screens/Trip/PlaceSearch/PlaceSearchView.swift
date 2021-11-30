//
//  PlaceSearchView.swift
//  Your luggage
//
//  Created by Igor Bachek on 11.11.21.
//

import UIKit

final class PlaceSearchView: UISearchController {
    var viewModel: PlaceSearchViewModelProtocol
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: PlaceSearchViewModelProtocol) {
        self.viewModel = viewModel
        let resultsView: SearchResults<PlaceSearchResultCell> = SearchResults.init(viewModel: viewModel.searchResultsViewModel)
        super.init(searchResultsController: resultsView)
        searchResultsUpdater = viewModel.searchResultsViewModel
        searchBar.setupSearchCityBar(
            backgroundColor: .backgroundColor,
            cornerRadius: 10,
            borderWidth: 1,
            borderColor: .limeGreen,
            textColor: .fireOrange
        )
        self.viewModel.searchEnded = { [weak self] (placeName: String) in
            self?.searchBar.resignFirstResponder()
            self?.searchBar.text = placeName
            self?.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .limeGreen
    }
    
}
