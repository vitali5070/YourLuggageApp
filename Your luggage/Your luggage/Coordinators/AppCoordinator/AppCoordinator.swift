import Foundation

final class AppCoordinator: CoordinatorProtocol {
    private enum Scene {
        case login
        case trip(String)
    }
    
    private let session: SessionProtocol
    private let navigator: NavigatorProtocol
    private let sceneFactory: AppCoordinatorSceneFactoryProtocol
    
    init(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        sceneFactory: AppCoordinatorSceneFactoryProtocol = AppCoordinatorSceneFactory()
    ) {
        self.navigator = navigator
        self.sceneFactory = sceneFactory
        self.session = session
    }
    
    func start() {
        navigator.coordinator = self
        
        if let userId = session.userRepository.userID {
            route(to: .trip(userId))
        } else {
            route(to: .login)
        }
    }
}

// MARK: - Route
fileprivate extension AppCoordinator {
    
    private func route(to scene: Scene) {
        switch scene {
        case .login:
            diplayLoginScene()
        case .trip(let userID):
            diplayTripScene(with: userID)
        }
    }
}

// MARK: - .login Navigation
extension AppCoordinator {
    
    func diplayLoginScene() {
        let handlers = AuthCoordinator.Handlers(
            success: { [weak self] userID in
                self?.route(to: .trip(userID))
            }
        )
        
        sceneFactory.startLoginSceneCoordinator(navigator: navigator, session: session, handlers: handlers)
    }
}

// MARK: - .tripScene Navigation
extension AppCoordinator {
    
    func diplayTripScene(with userID: String) {
        let handlers = AuthCoordinator.Handlers(
            success: { [weak self] userID in
                self?.route(to: .trip(userID))
            }
        )
        
        sceneFactory.startTripSceneCoordinator(navigator: navigator, session: session, userID: userID, handlers: handlers)
    }
}

