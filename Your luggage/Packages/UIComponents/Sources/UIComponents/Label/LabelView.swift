//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit

public class LabelView: UILabel {
    let viewModel: LabelViewModelProtocol
    
    public init(viewModel: LabelViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        text = viewModel.text
        apply(typography: viewModel.typography)
        textAlignment = .left
        contentHuggingPriority(for: .horizontal)
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
