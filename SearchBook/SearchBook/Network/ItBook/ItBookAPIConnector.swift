//
//  ItBookAPIConnector.swift
//  NetworkKit
//
//  Created by USER on 2022/02/18.
//

import Foundation

protocol ItBookAPIConnectorProtocol {
    
    func search(request: SearchRequest, completion: @escaping (SearchResponse?, NetworkError?) -> Void)
    func books(request : BooksReqeust, completion: @escaping(BooksResponse?, NetworkError?) -> Void)
}

final class ItBookAPIConnector: ItBookAPIConnectorProtocol {
    
    private let urlSessionConnector: URLSessionConnectorProtocol = URLSessionConnector()
    
    func search(request: SearchRequest, completion: @escaping (SearchResponse?, NetworkError?) -> Void) {
        guard let urlRequest = ItBookAPI.search(request: request).urlRequest else {
            completion(nil, NetworkError(type: .preconditionFailed(desc: "Search URLRequest")))
            return
        }
        let result = self.urlSessionConnector.dataTask(SearchResponse.self, urlRequest: urlRequest)
        completion(result.response, result.error)
        
    }
    
    func books(request: BooksReqeust, completion: @escaping (BooksResponse?, NetworkError?) -> Void) {
        guard let urlRequest = ItBookAPI.books(request: request).urlRequest else {
            completion(nil, NetworkError(type: .preconditionFailed(desc: "Books URLRequest")))
            return
        }
        let result = self.urlSessionConnector.dataTask(BooksResponse.self, urlRequest: urlRequest)
        completion(result.response, result.error)
    }
}
