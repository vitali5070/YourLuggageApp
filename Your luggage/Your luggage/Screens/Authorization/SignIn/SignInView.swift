import UIKit
import UIComponents
import SnapKit

final class SignInView: BaseViewController<SignInViewModelProtocol> {
    private enum Constants {
        static let textFieldLeadingTrailingConstant: CGFloat = 40
        static let textFieldStackHeightConstant: CGFloat = 100
        static let textfieldToSignInButtonConstant: CGFloat = 40
        static let logoHeightWidthConstant: CGFloat = 150
        static let logoToTextfieldConstant: CGFloat = -4
        static let signInButtonStackLeadingTrailingConstant: CGFloat = 112
        static let signInButtonStackHeightConstant: CGFloat = 50
        static let signUpStackBottomConstant: CGFloat = -20
        static let signUpStackHeightConstant: CGFloat = 25
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func setupView() {
        let model = viewModel
        let loginTextField = TextFieldView(viewModel: model.username)
        let passwordTextField = TextFieldView(viewModel: model.password)
        passwordTextField.isSecureTextEntry = true
        
        let textFieldStack = UIStackView()
            .verticalStack()
            .with(loginTextField, passwordTextField)
        view.addSubview(textFieldStack)
        textFieldStack.snp.makeConstraints { make -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textFieldLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.textFieldLeadingTrailingConstant)
            make.height.equalTo(Constants.textFieldStackHeightConstant)
        }
        
        let logoImageView = ImageView(viewModel: model.logo)
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make -> Void in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(textFieldStack.snp_topMargin).offset(Constants.logoToTextfieldConstant)
            make.height.equalTo(Constants.logoHeightWidthConstant)
            make.width.equalTo(Constants.logoHeightWidthConstant)
        }
        
        let signInButton = ButtonView(viewModel: model.signInButton)
//        let signInWithAppleButton = ButtonView(viewModel: model.signInWithAppleButton)
        
        let signInButtonnStack = UIStackView()
            .verticalStack()
            .with(signInButton)
        view.addSubview(signInButtonnStack)
        signInButtonnStack.snp.makeConstraints { make -> Void in
            make.top.equalTo(textFieldStack.snp_bottomMargin).offset(Constants.textfieldToSignInButtonConstant)
            make.leading.equalToSuperview().offset(Constants.signInButtonStackLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.signInButtonStackLeadingTrailingConstant)
            make.height.equalTo(Constants.signInButtonStackHeightConstant)
        }
        
        let title = LabelView(viewModel: model.title)
        
        let signUpButton = ButtonView(viewModel: model.signUpButton)
        if overrideUserInterfaceStyle == .dark {
            signUpButton.setTitleColor(UIColor(named: "Orange"), for: .normal)
        } else {
            signUpButton.setTitleColor(UIColor(named: "Forest green"), for: .normal)
        }
        
        let signUpStack = UIStackView()
            .horizontalStack()
            .with(title, signUpButton)
        view.addSubview(signUpStack)
        signUpStack.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(self.view.snp_bottomMargin).offset(Constants.signUpStackBottomConstant)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.signUpStackHeightConstant)
        }
    }
}
