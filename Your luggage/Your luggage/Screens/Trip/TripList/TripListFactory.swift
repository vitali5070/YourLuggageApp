//
//  TripFactory.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/1/21.
//

import UIKit
import YourLuggageCore

protocol TripListFactoryProtocol {
    func make(using router: TripList.Router,
              tripRepository: TripRepositoryProtocol,
              userRepository: UserRepositoryProtocol,
              userID: String
    ) -> UIViewController
}

struct TripList {
    typealias Services = AuthorizationServiceHolderProtocol

    struct Router {
        let addTrip: () -> Void
        let trip: () -> Void
    }

    struct Factory: TripListFactoryProtocol {
        func make(using router: TripList.Router,
                  tripRepository: TripRepositoryProtocol,
                  userRepository: UserRepositoryProtocol,
                  userID: String
        ) -> UIViewController
        {
            let viewModel = TripListViewModel(router: router, tripRepository: tripRepository, userRepository: userRepository, userID: userID)
            return TripListView(viewModel: viewModel)
        }
    }
}
