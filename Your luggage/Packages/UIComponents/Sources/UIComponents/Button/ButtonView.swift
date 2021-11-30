//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit

public class ButtonView: UIButton {
    let viewModel: ButtonViewModelProtocol
    
    public init(viewModel: ButtonViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        
        setTitle(viewModel.text, for: .normal)
        setImage(viewModel.image, for: .normal)
        backgroundColor = viewModel.backgroundColor
        if let borderWidth = viewModel.borderWidth {
            layer.borderWidth = borderWidth
        }
        if let borderColor = viewModel.borderColor {
            layer.borderColor = borderColor.cgColor
        }
        tintColor = viewModel.tintColor
        
        addTarget(self, action: #selector(tapAction), for: .touchUpInside)
    }
    
    override public init(frame: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewModel.style {
        case .oval:
            layer.cornerRadius = bounds.height / 2
            if imageView != nil && titleLabel != nil {
                imageEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: (bounds.width - 45))
                titleEdgeInsets = UIEdgeInsets(left: 0, right: (imageView?.frame.width)!)
            }
            break
        case .rounded:
            layer.cornerRadius = bounds.height / 2
            break
        case .rect:
            layer.cornerRadius = 10
            titleLabel?.apply(typography: .rectButton)
            break
        case .none:
            break
        }
    }
    
    @objc func tapAction() {
        viewModel.action()
    }
}
