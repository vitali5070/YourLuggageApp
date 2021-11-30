//
//  File.swift
//
//
//  Created by Vitaly Nabarouski on 11/4/21.
//

import Foundation

public protocol ConfigRepositoryHolderProtocol {
    var configRepository: ConfigRepositoryProtocol { get }
}

public protocol ConfigRepositoryProtocol {
    var appConfig: AppConfigProtocol { get }
}

public class ConfigRepository: ConfigRepositoryProtocol {
    public let appConfig: AppConfigProtocol = AppConfig()
    
    public init() { }
}

public struct ConfigRepositoryMock: ConfigRepositoryProtocol {
    public var appConfig: AppConfigProtocol = AppConfig()
    
    public init() { }
}
