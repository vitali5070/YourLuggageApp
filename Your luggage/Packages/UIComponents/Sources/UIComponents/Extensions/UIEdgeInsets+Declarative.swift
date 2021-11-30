//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/2/21.
//

import UIKit

extension UIEdgeInsets {
    
    public func authTextFieldEdgeInsets() -> UIEdgeInsets {
        let authTextFieldInset: CGFloat = 8
        return UIEdgeInsets(top: authTextFieldInset,
                            left: authTextFieldInset,
                            bottom: authTextFieldInset,
                            right: authTextFieldInset)
    }
    
    public func roudedButtonImageEdgeInsets() -> UIEdgeInsets {
        let roudedButtonImageInset: CGFloat = 8
        return UIEdgeInsets(top: roudedButtonImageInset,
                            left: roudedButtonImageInset,
                            bottom: roudedButtonImageInset,
                            right: roudedButtonImageInset)
    }
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.init()
        self.top = top
        self.bottom = bottom
    }
    
    public init(left: CGFloat, right: CGFloat) {
        self.init()
        self.left = left
        self.right = right
    }
}
