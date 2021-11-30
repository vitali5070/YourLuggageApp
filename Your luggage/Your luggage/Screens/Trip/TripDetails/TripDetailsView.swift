//
//  TripDetailsView.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/10/21.
//

import UIKit
import UIComponents
import YourLuggageCore
import SnapKit

final class TripDetailsView: BaseViewController<TripDetailsViewModelProtocol> {
    private enum Constants {
        static let backButtonSize: CGSize = CGSize(width: 36, height: 36)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
    }
    
    private func setupNavigation() {
        navigationItem.hidesSearchBarWhenScrolling = false
        
        let backButton = ButtonView(viewModel: viewModel.backButton)
        backButton.snp.makeConstraints { make in
            make.height.equalTo(Constants.backButtonSize.height)
            make.width.equalTo(Constants.backButtonSize.width)
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
}
