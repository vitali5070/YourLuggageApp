import UIKit
import UIComponents

protocol SignInViewModelProtocol: AnyObject {
    var title: LabelViewModelProtocol { get }
    var logo: ImageViewModelProtocol { get }
    var username: TextFieldViewModelProtocol { get }
    var password: TextFieldViewModelProtocol { get }
    var signInButton: ButtonViewModelProtocol { get }
    //    var signInWithAppleButton: ButtonViewModelProtocol { get }
    var signUpButton: ButtonViewModelProtocol { get }
}

final class SignInViewModel: SignInViewModelProtocol {
    
    let title: LabelViewModelProtocol = LabelViewModel(
        text: "I'm a new user,",
        typography: Typography.blackSFProDisplayRegularSmall
    )
    
    lazy var signUpButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Sign up",
        style: .none,
        action: { [weak self] in
            self?.router.trySignUp()
        }
    )
    
    lazy var signInButton: ButtonViewModelProtocol = ButtonViewModel(
        text: "Sign in",
        style: .oval,
        backgroundColor: UIColor.limeGreen,
        action: { [weak self] in
            guard let self = self,
                  let email = self.username.text,
                  let password = self.password.text
            else {
                return
            }
            self.handleSignInButtonAction(with: email, password: password)
        }
    )
    
    //    lazy var signInWithAppleButton: ButtonViewModelProtocol = ButtonViewModel(
    //        text: "Sign in",
    //        image: UIImage(named: "appleLogo"),
    //        style: .oval,
    //        backgroundColor: .black,
    //        action: { [weak self] in
    //            self?.router.trySignUp()
    //        }
    //    )
    
    var logo: ImageViewModelProtocol = ImageViewModel(
        image: .bundle("logo"),
        borderWidth: 3,
        borderColor: .limeGreen
    )
    
    var username: TextFieldViewModelProtocol = TextFieldViewModel(
        placeholder: "User name",
        backgroundColor: .backgroundColor,
        borderWidth: 1,
        borderColor: .limeGreen,
        placeholderColor: .placeholderColor,
        textColor: .fireOrange,
        cornerRadius: 10,
        validateOnEndActive: true,
        type: .email
    )
    
    var password: TextFieldViewModelProtocol = TextFieldViewModel(
        placeholder: "Password",
        backgroundColor: .backgroundColor,
        borderWidth: 1,
        borderColor: .limeGreen,
        placeholderColor: .placeholderColor, 
        textColor: .fireOrange,
        cornerRadius: 10,
        validateOnEndActive: false,
        type: .password
    )
    
    private let repositories: SignIn.Repositories
    private let router: SignIn.Router
    
    private func handleSignInButtonAction(with email: String, password: String) {
        self.repositories.userRepository.signIn(
            with: email,
            password: password,
            completion: { result in
                switch result {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let userID):
                    self.router.success(userID)
                }
            }
        )
    }
    
    init(repositories: SignIn.Repositories, router: SignIn.Router) {
        self.repositories = repositories
        self.router = router
    }
}
