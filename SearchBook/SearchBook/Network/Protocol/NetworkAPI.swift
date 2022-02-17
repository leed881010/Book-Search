//
//  NetworkAPI.swift
//  SearchBook
//
//  Created by USER on 2022/02/18.
//

import Foundation

protocol NetworkAPI {
    
    var urlRequest: URLRequest? { get }
    
    var urlString: String { get }
    var domain: String { get }
    var path: String { get }
    var pathParam: String { get }
    var httpMethod: String { get }
}

extension NetworkAPI {
    
    var urlRequest: URLRequest? {
        guard let url: URL = .init(string: self.urlString) else { return nil }
        var request: URLRequest = .init(url: url)
        request.httpMethod = self.httpMethod
        return request
    }
    
}
