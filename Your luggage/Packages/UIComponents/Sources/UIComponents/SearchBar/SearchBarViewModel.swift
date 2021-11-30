//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/8/21.
//

import UIKit

public protocol SearchBarViewModelProtocol {
    var placeholderText: String { get }
    var placeholderColor: UIColor? { get }
    var borderWidth: CGFloat? { get }
    var borderColor: UIColor? { get }
}

public class SearchBarViewModel: SearchBarViewModelProtocol {
    public var placeholderText: String
    public var borderWidth: CGFloat?
    public var borderColor: UIColor?
    public let placeholderColor: UIColor?
    
    public init(
        placeholderText: String,
        placeholderColor: UIColor? = .fireOrange,
        borderWidth: CGFloat? = 0,
        borderColor: UIColor? = .clear
    ) {
        self.placeholderText = placeholderText
        self.placeholderColor = placeholderColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
    }
}
