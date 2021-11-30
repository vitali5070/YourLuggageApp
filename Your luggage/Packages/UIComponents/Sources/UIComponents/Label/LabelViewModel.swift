//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 10/28/21.
//

import UIKit

public protocol LabelViewModelProtocol {
    var text: String { get }
    var typography: Typography { get }
}

public class LabelViewModel: LabelViewModelProtocol {
    public let text: String
    public let typography: Typography
    
    public init(
        text: String,
        typography: Typography
    ) {
        self.text = text
        self.typography = typography
    }
}
