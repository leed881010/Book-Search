//
//  NetworkDispatcher.swift
//  SearchBook
//
//  Created by USER on 2022/02/18.
//

import Foundation

protocol NetworkDispatcherProtocol {
    
    var itbookAPIConnector: ItBookAPIConnectorProtocol { get }
    
}

final class NetworkDispatcher: NetworkDispatcherProtocol {
    
    static let shared: NetworkDispatcherProtocol = NetworkDispatcher()
    
    let itbookAPIConnector: ItBookAPIConnectorProtocol = ItBookAPIConnector()
}

