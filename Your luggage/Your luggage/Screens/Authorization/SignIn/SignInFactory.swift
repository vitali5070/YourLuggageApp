import UIKit
import YourLuggageCore

protocol SignInFactoryProtocol {
    func make(using services: SignIn.Repositories, router: SignIn.Router) -> UIViewController
}

struct SignIn {
    // Input
    typealias Repositories = UserRepositoryHolderProtocol

    // Output
    struct Router {
        let success: (_ userID: String) -> Void
        let trySignUp: () -> Void
    }

    struct Factory: SignInFactoryProtocol {
        func make(using repositories: Repositories, router: Router) -> UIViewController {
            let viewModel = SignInViewModel(repositories: repositories, router: router)
            return SignInView(viewModel: viewModel)
        }
    }
}
