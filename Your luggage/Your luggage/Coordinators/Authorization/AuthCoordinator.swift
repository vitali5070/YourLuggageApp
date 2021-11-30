import Foundation

final class AuthCoordinator: CoordinatorProtocol {
    struct Handlers {
        let success: (_ userID: String) -> Void
    }
    
    private enum Scene {
        case signIn
        case signUp
    }
    
    private let session: SessionProtocol
    private let navigator: NavigatorProtocol
    private let handlers: Handlers
    private let sceneFactory: AuthCoordinatorSceneFactoryProtocol
    
    init(
        session: SessionProtocol,
        navigator: NavigatorProtocol,
        handlers: Handlers,
        sceneFactory: AuthCoordinatorSceneFactoryProtocol = AuthCoordinatorSceneFactory()
    ) {
        self.session = session
        self.navigator = navigator
        self.handlers = handlers
        self.sceneFactory = sceneFactory
    }
    
    func start() {
        navigator.coordinator = self
        route(to: .signIn)
    }
}

// MARK: - Route
fileprivate extension AuthCoordinator {
    
    private func route(to scene: Scene) {
        switch scene {
        case .signIn:
            diplaySignInScene()
        case .signUp:
            diplaySignUpScene()
        }
    }
}

// MARK: - .signIn Navigation
extension AuthCoordinator {
    
    func diplaySignInScene() {
        navigator.push(
            sceneFactory.makeSignInScene(session: session, router: .init(
                success: { [weak self] userID in
                    self?.handlers.success(userID)
                },
                trySignUp: { [weak self] in
                    self?.route(to: .signUp)
                }
            )
            )
        )
    }
}

// MARK: - .signUp Navigation
extension AuthCoordinator {
    
    func diplaySignUpScene() {
        navigator.push(
            sceneFactory.makeSignUpScene(
                session: session,
                router: .init(
                    success: { [weak self] userID in
                        self?.handlers.success(userID)
                    },
                    signIn: { [weak self] in
                        self?.route(to: .signIn)
                    }
                )
            )
        )
    }
}

extension AuthCoordinator.Handlers {
    static func mock() -> AuthCoordinator.Handlers {
        .init(success: { _ in })
    }
}
