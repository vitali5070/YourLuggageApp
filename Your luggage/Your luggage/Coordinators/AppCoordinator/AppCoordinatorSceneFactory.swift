import Foundation

protocol AppCoordinatorSceneFactoryProtocol {
    func startLoginSceneCoordinator(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        handlers: AuthCoordinator.Handlers
    )

    func startTripSceneCoordinator(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        userID: String,
        handlers: Any
    )
}

final class AppCoordinatorSceneFactory: AppCoordinatorSceneFactoryProtocol {
    func startLoginSceneCoordinator(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        handlers: AuthCoordinator.Handlers
    ) {
        let loginCoordinator = AuthCoordinator(session: session, navigator: navigator, handlers: handlers)
        loginCoordinator.start()
    }

    func startTripSceneCoordinator(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        userID:String,
        handlers: Any
    ) {
        let tripCoordinator = TripCoordinator(session: session, navigator: navigator, userID: userID)
        tripCoordinator.start()
    }
}

class AppCoordinatorSceneFactoryMock: AppCoordinatorSceneFactoryProtocol {
    var startLoginCoordinatorCalled: Bool = false
    var startLoginCoordinatorHandlers = AuthCoordinator.Handlers.mock()

    func startLoginSceneCoordinator(
        navigator: NavigatorProtocol = NavigatorMock(),
        session: SessionProtocol = SessionMock(),
        handlers: AuthCoordinator.Handlers = AuthCoordinator.Handlers.mock()
    ) {
        startLoginCoordinatorCalled = true
        startLoginCoordinatorHandlers = handlers
    }


    var startNextSceneCoordinatorCalled: Bool = false
    var startNextSceneCoordinatorHandlers = [Any]()
    func startTripSceneCoordinator(
        navigator: NavigatorProtocol,
        session: SessionProtocol,
        userID: String,
        handlers: Any
    ) {
        startNextSceneCoordinatorCalled = true
        startNextSceneCoordinatorHandlers.append(handlers)
    }
}
