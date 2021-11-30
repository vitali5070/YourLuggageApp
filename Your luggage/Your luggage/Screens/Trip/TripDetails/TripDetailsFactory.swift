//
//  TripDetailsFactory.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/10/21.
//

import UIKit
import YourLuggageCore

protocol TripDetailsFactoryProtocol {
    func make(using router: TripDetails.Router, tripRepository: TripRepositoryProtocol) -> UIViewController
}

struct TripDetails {
    typealias Services = AuthorizationServiceHolderProtocol

    struct Router {
        let tripList: () -> Void
    }
    
    struct Factory: TripDetailsFactoryProtocol {
        func make(using router: Router, tripRepository: TripRepositoryProtocol) -> UIViewController {
            let viewModel = TripDetailsViewModel(router: router, tripRepository: tripRepository)
            return TripDetailsView(viewModel: viewModel)
        }
    }
}
