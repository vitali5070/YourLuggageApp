//
//  PlaceSearchResultCell.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11.11.21.
//

import UIKit

final class PlaceSearchResultCell: UITableViewCell, SearchResultCellProtocol {
    typealias ViewModel = PlaceSearchResultCellViewModel

    private enum Constants {
        static let contentViewOffset: CGFloat = 8
    }

    func configureCell(with viewModel: ViewModel) {
        textLabel?.text = viewModel.text
        textLabel?.textColor = .fireOrange
        textLabel?.font = UIFont.semiBold(20)
        backgroundColor = .clear
        selectionStyle = .none
    }
}
