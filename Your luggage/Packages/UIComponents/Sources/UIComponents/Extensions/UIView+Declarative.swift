//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/2/21.
//

import UIKit
import SnapKit

public extension UIView {
    
    private enum Constants {
        static let titleLeadingConstant = 24
        static let subtitleLeadingConstant = 16
        static let titleToSubtitleConstant = 8
    }
    
    func setNavigationTitle(title: String,
                            subTitle: String,
                            titleTypography: Typography,
                            subTitleTypography: Typography) -> UIView {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.backgroundColor = .clear
        titleLabel.textAlignment = .left
        titleLabel.text = title
        titleLabel.apply(typography: titleTypography)
        
        let subTitleLabel = UILabel(frame: .zero)
        subTitleLabel.backgroundColor = .clear
        subTitleLabel.textAlignment = .left
        subTitleLabel.text = subTitle
        subTitleLabel.apply(typography: subTitleTypography)
        
        let titleView = UIView(frame: .zero)
        titleView.addSubview(titleLabel)
        titleView.addSubview(subTitleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(Constants.titleLeadingConstant)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp_bottomMargin).offset(Constants.titleToSubtitleConstant)
            make.leading.equalTo(titleLabel).offset(Constants.subtitleLeadingConstant)
        }
        return titleView
    }
}
