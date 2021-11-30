//
//  SearchViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/9/21.
//

import UIKit

class SearchResultsViewModel<CellViewModel>: NSObject, UISearchResultsUpdating {
    var reloadData: () -> Void = { }
    let didSelectResult: (CellViewModel) -> Void

    init(didSelectResult: @escaping (CellViewModel) -> Void) {
        self.didSelectResult = didSelectResult
    }

    var itemsCount: Int {
        fatalError("itemsCount has not been implemented")
    }
    
    func searchResultViewModel(at indexPath: IndexPath) -> CellViewModel {
        fatalError("searchResultViewModel(at:) has not been implemented")
    }

    final func didDeselectSearchResult(at indexPath: IndexPath) {
        let result = searchResultViewModel(at: indexPath)
        didSelectResult(result)
    }

    func updateSearchResults(for searchController: UISearchController) {
        fatalError("updateSearchResults(for:) has not been implemented")
    }
}


