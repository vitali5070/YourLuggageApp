//
//  TripCellViewModel.swift
//  Your luggage
//
//  Created by Vitaly Nabarouski on 11/4/21.
//

import Foundation

public protocol TripCellViewModelProtocol {
    var city: String? { get }
    var date: String? { get }
    var imageData: Data? { get }
}

public class TripCellViewModel: TripCellViewModelProtocol {
    public let city: String?
    public let date: String?
    public let imageData: Data?
    
    init(
        city: String?,
        date: String?,
        imageData: Data?
    ) {
        self.city = city
        self.date = date
        self.imageData = imageData
    }
}
