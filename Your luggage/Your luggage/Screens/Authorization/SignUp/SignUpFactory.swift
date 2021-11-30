//
//  SignUpFactory.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit
import YourLuggageCore
import CoreData

protocol SignUpFactoryProtocol {
    func make(using services: SignUp.Repositories, router: SignUp.Router) -> UIViewController
}

struct SignUp {
    // Input
    typealias Repositories = UserRepositoryHolderProtocol

    // Output
    struct Router {
        let success: (String) -> Void
        let signIn: () -> Void
    }

    struct Factory: SignUpFactoryProtocol {
        func make(using repositories: Repositories, router: Router) -> UIViewController {
            let viewModel = SignUpViewModel(repositories: repositories, router: router)
            return SignUpView(viewModel: viewModel)
        }
    }
}
