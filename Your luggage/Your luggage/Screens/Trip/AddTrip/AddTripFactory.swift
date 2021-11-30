//
//  AddTripFactory.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/8/21.
//

import UIKit
import YourLuggageCore

protocol AddTripFactoryProtocol {
    func make(using router: AddTrip.Router,
              tripRepository: TripRepositoryProtocol,
              userRepository: UserRepositoryProtocol,
              configRepository: ConfigRepositoryProtocol) -> UIViewController
}

struct AddTrip {
    typealias Services = AuthorizationServiceHolderProtocol

    struct Router {
        let tripList: () -> Void
        let trip: () -> Void
    }
    
    struct Factory: AddTripFactoryProtocol {
        func make(using router: Router, tripRepository: TripRepositoryProtocol, userRepository: UserRepositoryProtocol, configRepository: ConfigRepositoryProtocol) -> UIViewController {
            let viewModel = AddTripViewModel(router: router, tripRepository: tripRepository, userRepository: userRepository, configRepository: configRepository)
            return AddTripView(viewModel: viewModel)
        }
    }
}

