//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit

public enum ButtonStyle {
    case rounded
    case oval
    case rect
    case none
}

public protocol ButtonViewModelProtocol: AnyObject {
    var text: String? { get }
    var image: UIImage? { get }
    var style: ButtonStyle { get }
    var backgroundColor: UIColor? { get }
    var borderWidth: CGFloat? { get }
    var borderColor: UIColor? { get }
    var tintColor: UIColor? { get }
    var action: () -> Void { get }
}

public class ButtonViewModel: ButtonViewModelProtocol {
    public let text: String?
    public let image: UIImage?
    public let style: ButtonStyle
    public let backgroundColor: UIColor?
    public let borderWidth: CGFloat?
    public let borderColor: UIColor?
    public let tintColor: UIColor?
    public let action: () -> Void
    
    public init(
        text: String?,
        image: UIImage? = nil,
        style: ButtonStyle,
        backgroundColor: UIColor? = nil,
        borderWidth: CGFloat? = 0,
        borderColor: UIColor? = .clear,
        tintColor: UIColor? = .black,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.image = image
        self.style = style
        self.backgroundColor = backgroundColor
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.tintColor = tintColor
        self.action = action
    }
}
