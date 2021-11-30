//
//  SignUpView.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit
import UIComponents
import SnapKit

final class SignUpView: BaseViewController<SignUpViewModelProtocol> {
    
    private enum Constants {
        static let leadingTitleConstant: CGFloat = 40
        static let topTitleConstant: CGFloat = 104
        static let titleToSubtitleConstant: CGFloat = 8
        static let textFieldLeadingTrailingConstant: CGFloat = 40
        static let textFieldStackHeightConstant: CGFloat = 160
        static let textFieldStackToLoginButton: CGFloat = 40
        static let loginButtonLeadingTrailingConstant: CGFloat = 112
        static let loginButtonHeightConstant: CGFloat = 44
        static let signInStackBottomConstant: CGFloat = -20
        static let signInStackHeightConstant: CGFloat = 25
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        setupView()
    }
    
    private func setupView() {
        let title = LabelView(viewModel: viewModel.title)
        view.addSubview(title)
        title.snp.makeConstraints { make -> Void in
            make.leading.equalToSuperview().offset(Constants.leadingTitleConstant)
            make.top.equalToSuperview().offset(Constants.topTitleConstant)
        }
        
        let subTitle = LabelView(viewModel: viewModel.subTitle)
        view.addSubview(subTitle)
        subTitle.snp.makeConstraints { make -> Void in
            make.top.equalTo(title.snp_bottomMargin).offset(Constants.titleToSubtitleConstant)
            make.centerX.equalToSuperview()
        }
        
        let userNameTextField = TextFieldView(viewModel: viewModel.userName)
        let emailTextField = TextFieldView(viewModel: viewModel.email)
        let passwordTextField = TextFieldView(viewModel: viewModel.password)
        passwordTextField.isSecureTextEntry = true
        let textFieldStack = UIStackView()
            .verticalStack()
            .with(userNameTextField, emailTextField, passwordTextField)
        view.addSubview(textFieldStack)
        textFieldStack.snp.makeConstraints { make -> Void in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.textFieldLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.textFieldLeadingTrailingConstant)
            make.height.equalTo(Constants.textFieldStackHeightConstant)
        }
        
        let loginButton = ButtonView(viewModel: viewModel.loginButton)
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make -> Void in
            make.top.equalTo(textFieldStack.snp_bottomMargin).offset(Constants.textFieldStackToLoginButton)
            make.leading.equalToSuperview().offset(Constants.loginButtonLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.loginButtonLeadingTrailingConstant)
            make.height.equalTo(Constants.loginButtonHeightConstant)
        }
        
        let bottomTitle = LabelView(viewModel: viewModel.bottomTitle)
        let signInButton = ButtonView(viewModel: viewModel.signInButton)
        if overrideUserInterfaceStyle == .dark {
            signInButton.setTitleColor(UIColor(named: "Orange"), for: .normal)
        } else {
            signInButton.setTitleColor(UIColor(named: "Forest green"), for: .normal)
        }
        
        let signInStack = UIStackView()
            .horizontalStack()
            .with(bottomTitle, signInButton)
        view.addSubview(signInStack)
        signInStack.snp.makeConstraints { make -> Void in
            make.bottom.equalTo(self.view.snp_bottomMargin).offset(Constants.signInStackBottomConstant)
            make.centerX.equalToSuperview()
            make.height.equalTo(Constants.signInStackHeightConstant)
        }
    }
}
