//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/8/21.
//

import UIKit

public class SearchBarView: UISearchBar {
    let viewModel: SearchBarViewModelProtocol
    
    public init(viewModel: SearchBarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        backgroundColor = .backgroundColor
        layer.borderWidth = viewModel.borderWidth ?? 0
        layer.borderColor = viewModel.borderColor?.cgColor
        placeholder = viewModel.placeholderText
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
