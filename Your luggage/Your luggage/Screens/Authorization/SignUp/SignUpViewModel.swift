//
//  SignUpViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit
import UIComponents
import YourLuggageCore

protocol SignUpViewModelProtocol: AnyObject {
    var title: LabelViewModelProtocol { get }
    var subTitle: LabelViewModelProtocol { get }
    var email: TextFieldViewModelProtocol { get }
    var password: TextFieldViewModelProtocol { get }
    var userName: TextFieldViewModelProtocol { get }
    var loginButton: ButtonViewModelProtocol { get }
    var bottomTitle: LabelViewModelProtocol { get }
    var signInButton: ButtonViewModelProtocol { get }
    
}

final class SignUpViewModel: SignUpViewModelProtocol {
    let title: LabelViewModelProtocol = LabelViewModel(
        text: "Create Account,",
        typography: .blackSFProDisplayBoldLarge)
    
    let subTitle: LabelViewModelProtocol = LabelViewModel(
        text: "Sign up to get started!",
        typography: .forestGreenSFProDisplayBoldLarge
    )
    
    let email: TextFieldViewModelProtocol = TextFieldViewModel(
        placeholder: "Email",
        backgroundColor: .backgroundColor,
        borderWidth: 1,
        borderColor: .limeGreen,
        placeholderColor: .placeholderColor,
        textColor: .fireOrange,
        cornerRadius: 10,
        validateOnEndActive: true,
        type: .email
    )
    
    let password: TextFieldViewModelProtocol = TextFieldViewModel(
        placeholder: "Password",
        backgroundColor: .backgroundColor,
        borderWidth: 1,
        borderColor: .limeGreen,
        placeholderColor: .placeholderColor,
        textColor: .fireOrange,
        cornerRadius: 10,
        validateOnEndActive: true,
        type: .password
    )
    
    let userName: TextFieldViewModelProtocol = TextFieldViewModel(
        placeholder: "Full name",
        backgroundColor: .backgroundColor,
        borderWidth: 1,
        borderColor: .limeGreen,
        placeholderColor: .placeholderColor,
        textColor: .fireOrange,
        cornerRadius: 10,
        validateOnEndActive: true,
        type: .name
    )
    
    lazy var loginButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Sign up",
        style: .oval,
        backgroundColor: .limeGreen,
        action: { [weak self] in
            guard let self = self,
                  let email = self.email.text,
                  let password = self.password.text,
                  let fullName = self.userName.text
            else {
                return
            }
            
            self.repositories.userRepository.signUp(
                with: email,
                password: password,
                fullName: fullName,
                completion: { result in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                    case .success(let userID):
                        self.repositories.userRepository.saveUser(with: userID)
                        print("UserID in SignUpViewModel: \(userID)")
                        self.router.success(userID)
                    }
                }
            )
        }
    )
    
    let bottomTitle: LabelViewModelProtocol = LabelViewModel(
        text: "I'm already a member,",
        typography: .blackSFProDisplayRegularSmall)
    
    lazy var signInButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Sign in",
        style: .oval,
        action: { [weak self] in
            self?.router.signIn()
        }
    )
    
    private var repositories: SignUp.Repositories
    private let router: SignUp.Router
    private let storage: TripStorageProtocol
    
    init(repositories: SignUp.Repositories, router: SignUp.Router) {
        self.repositories = repositories
        self.router = router
        self.storage = Storage()
    }
}
