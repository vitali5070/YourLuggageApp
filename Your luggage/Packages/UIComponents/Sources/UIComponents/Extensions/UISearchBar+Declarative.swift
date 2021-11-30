//
//  File.swift
//  
//
//  Created by Vitaly Nabarouski on 11/9/21.
//

import UIKit

extension UISearchBar {
    public func setupSearchCityBar(backgroundColor: UIColor, cornerRadius: CGFloat, borderWidth: CGFloat, borderColor: UIColor, textColor: UIColor) {
        self.tintColor = textColor
        self.barTintColor = textColor
        let searchTextField: UITextField? = self.value(forKey: "searchField") as? UITextField
        searchTextField?.leftViewMode = .never
        searchTextField?.clearButtonMode = .never
        searchTextField?.backgroundColor = backgroundColor
        searchTextField?.layer.cornerRadius = cornerRadius
        searchTextField?.layer.borderWidth = borderWidth
        searchTextField?.layer.borderColor = borderColor.cgColor
        searchTextField?.rightView?.tintColor = textColor
        searchTextField?.attributedPlaceholder = NSAttributedString(
            string: "Search city",
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.placeholderColor,
                NSAttributedString.Key.font : UIFont.semiBold(18) ?? UIFont.systemFont(ofSize: 18)])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor: textColor,
            NSAttributedString.Key.font : UIFont.semiBold(20) ?? UIFont.systemFont(ofSize: 20)]
    }
}
