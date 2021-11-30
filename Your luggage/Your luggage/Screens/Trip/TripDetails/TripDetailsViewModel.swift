//
//  TripDetailsViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/10/21.
//

import UIKit
import UIComponents
import YourLuggageCore
import CoreData
import FSCalendar

protocol TripDetailsViewModelProtocol: AnyObject {
    var backButton: ButtonViewModelProtocol { get }
}

final class TripDetailsViewModel: TripDetailsViewModelProtocol {
    lazy var backButton: ButtonViewModelProtocol = ButtonViewModel(
        text: nil,
        image: UIImage(systemName: "chevron.left"),
        style: .rounded,
        borderWidth: 3,
        borderColor: .limeGreen,
        tintColor: .fireOrange) { [weak self] in
        self?.router.tripList()
    }
        
    private let router: TripDetails.Router
    private let tripRepository: TripRepositoryProtocol
    
    init(router: TripDetails.Router,
         tripRepository: TripRepositoryProtocol) {
        self.router = router
        self.tripRepository = tripRepository
    }
}
