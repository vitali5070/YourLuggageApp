//
//  TripCoordinator.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/2/21.
//

import Foundation

final class TripCoordinator: CoordinatorProtocol {
    
    private enum Scene {
        case tripList
        case addTrip
        case trip
    }
    
    init(
        session: SessionProtocol,
        navigator: NavigatorProtocol,
        sceneFactory: TripCoordinatorSceneFactoryProtocol = TripCoordinatorSceneFactory(),
        userID: String
    ) {
        self.session = session
        self.navigator = navigator
        self.sceneFactory = sceneFactory
        self.userID = userID
        print("UserID in TripCoordinator: \(userID)")
    }
    
    private let session: SessionProtocol
    private let navigator: NavigatorProtocol
    private let sceneFactory: TripCoordinatorSceneFactoryProtocol
    private let userID: String
    
    func start() {
        navigator.coordinator = self
        route(to: .tripList)
    }
}

// MARK: - Route
fileprivate extension TripCoordinator {
    
    private func route(to scene: Scene) {
        switch scene {
        case .tripList:
            diplayTripListScene()
        case .addTrip:
            diplayAddTripScene()
        case .trip:
            displayTripScene()
        }
    }
}

// MARK: - .tripList Navigation
extension TripCoordinator {
    
    func diplayTripListScene() {
        navigator.set(
            sceneFactory.makeTripListScene(
                userID: userID,
                session: session,
                router: .init(
                    addTrip: { [weak self] in
                        self?.route(to: .addTrip)
                    },
                    trip: { [weak self] in
                        self?.route(to: .trip)
                    }
                )
            )
        )
    }
    
    func diplayAddTripScene() {
        navigator.push(
            sceneFactory.makeAddTripScene(
                session: session,
                router: .init(
                    tripList: { [weak self] in
                        self?.route(to: .tripList)
                    }, trip: { [weak self] in
                        self?.route(to: .trip)
                    }
                )
            )
        )
    }
    
    func displayTripScene() {
        navigator.push(sceneFactory.makeTripDetailsScene(
            session: session,
            router: .init(
                tripList: { [weak self] in
                    self?.route(to: .tripList)
                }
            )
        )
        )
    }
}
