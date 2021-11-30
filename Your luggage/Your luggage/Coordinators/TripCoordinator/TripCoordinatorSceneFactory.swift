//
//  TripCoordinatorSceneFactory.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/2/21.
//
import UIKit

protocol TripCoordinatorSceneFactoryProtocol {
    func makeTripListScene(userID: String, session: SessionProtocol, router: TripList.Router) -> UIViewController
    func makeAddTripScene(session: SessionProtocol, router: AddTrip.Router) -> UIViewController
    func makeTripDetailsScene(session: SessionProtocol, router: TripDetails.Router) -> UIViewController
}

final class TripCoordinatorSceneFactory: TripCoordinatorSceneFactoryProtocol {
    func makeTripListScene(userID: String, session: SessionProtocol, router: TripList.Router) -> UIViewController {
        TripList.Factory().make(using: router, tripRepository: session.tripRepository, userRepository: session.userRepository, userID: userID)
    }
    
    func makeAddTripScene(session: SessionProtocol, router: AddTrip.Router) -> UIViewController {
        AddTrip.Factory().make(using: router, tripRepository: session.tripRepository, userRepository: session.userRepository, configRepository: session.configRepository)
    }
    
    func makeTripDetailsScene(session: SessionProtocol, router: TripDetails.Router) -> UIViewController {
        TripDetails.Factory().make(using: router, tripRepository: session.tripRepository)
    }
}
