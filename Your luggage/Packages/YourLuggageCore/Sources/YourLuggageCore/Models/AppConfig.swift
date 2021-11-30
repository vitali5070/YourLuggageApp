//
//  File.swift
//
//
//  Created by Vitaly Nabarouski on 11/3/21.
//

import Foundation

public protocol AppConfigProtocol {
    var googlePlacesAPIKey: String { get }
}

public struct AppConfig: AppConfigProtocol {
    public let googlePlacesAPIKey = "AIzaSyAmv2AiZXpW5Fz55w6fOEiqRM2HW7hWNro"
}
