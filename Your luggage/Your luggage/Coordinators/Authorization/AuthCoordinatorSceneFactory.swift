import UIKit

protocol AuthCoordinatorSceneFactoryProtocol {
    func makeSignInScene(session: SessionProtocol, router: SignIn.Router) -> UIViewController
    func makeSignUpScene(session: SessionProtocol, router: SignUp.Router) -> UIViewController
}

final class AuthCoordinatorSceneFactory: AuthCoordinatorSceneFactoryProtocol {
    func makeSignInScene(session: SessionProtocol, router: SignIn.Router) -> UIViewController {
        SignIn.Factory().make(using: session, router: router)
    }

    func makeSignUpScene(session: SessionProtocol, router: SignUp.Router) -> UIViewController {
        SignUp.Factory().make(using: session, router: router)
    }
}
