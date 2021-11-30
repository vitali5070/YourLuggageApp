//
//  TripCellView.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/4/21.
//

import UIKit
import UIComponents
import SnapKit

final class TripCellView: UITableViewCell {
    private enum Constants {
        static let detailViewToImageViewBottomConstant: CGFloat = -20
        static let detailViewToImageViewLeadingTrailingConstant: CGFloat = 20
        static let detailViewHeight: CGFloat = 48
        static let cityLabelLeadingTrailingConstant: CGFloat = 20
        static let cityLabelTopConstant: CGFloat = 4
        static let dateLabelBottomOffset: CGFloat = 4 
        static let imageViewToContainerConstant: CGFloat = 10
        static let cellMultiplier: CGFloat = 10 / 15
    }
    
    func configureCell(with viewModel: TripCellViewModel) {
        contentView.backgroundColor = .backgroundColor
        
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFill
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.imageViewToContainerConstant)
            make.leading.equalToSuperview().offset(Constants.imageViewToContainerConstant)
            make.trailing.equalToSuperview().inset(Constants.imageViewToContainerConstant)
            make.bottom.equalToSuperview().inset(Constants.imageViewToContainerConstant)
            make.height.equalTo(contentView.frame.width * Constants.cellMultiplier)
        }
        
        var image: UIImage!
        if let imageData = viewModel.imageData {
        image = UIImage(data: imageData)
        }
        if let image = image {
        imageView.image = image
        }
 
        let detailView = UIView()
        detailView.backgroundColor = .tripCellDetailViewBackground
        detailView.layer.cornerRadius = 10
        
        imageView.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(Constants.detailViewToImageViewBottomConstant)
            make.leading.equalToSuperview().offset(Constants.detailViewToImageViewLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.detailViewToImageViewLeadingTrailingConstant)
            make.height.equalTo(Constants.detailViewHeight)
        }
        
        let cityLabelViewModel = LabelViewModel(text: viewModel.city ?? "City", typography: .tripCellCityLabel)
        let cityLabel = LabelView(viewModel: cityLabelViewModel)
        detailView.addSubview(cityLabel)
        cityLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Constants.cityLabelLeadingTrailingConstant)
            make.trailing.equalToSuperview().inset(Constants.cityLabelLeadingTrailingConstant)
            make.top.equalToSuperview().offset(Constants.cityLabelTopConstant)
        }
        
        let dateLabelViewModel = LabelViewModel(text: viewModel.date ?? "Date", typography: .tripCellDateLabel)
        let dateLabel = LabelView(viewModel: dateLabelViewModel)
        detailView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(Constants.dateLabelBottomOffset)
            make.centerX.equalToSuperview()
        }
    }
}
