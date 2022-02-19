//
//  SearchFactor.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol SearchFactorUpdaterProtocol: AnyObject {
    
    func next()
    func update(query: String)
    func update(isLast: Bool)
    
    var searchRequestHandler: ((SearchRequest?) -> Void)? { get }

    func bind(searchRequest handler: @escaping (SearchRequest?) -> Void)
}

class SearchFactorUpdater {
    
    private var page: Int = 1 {
        didSet {
            let request: SearchRequest? = self.isLast ? nil : SearchRequest(query: self.query, page: self.page)
            self.searchRequestHandler?(request)
        }
    }
    private var query: String = ""
    private var isLast: Bool = false
    private(set) var searchRequestHandler: ((SearchRequest?) -> Void)?
}

extension SearchFactorUpdater: SearchFactorUpdaterProtocol {
    
    func next() {
        self.page += 1
    }
    
    func update(query: String) {
        self.query = query
        self.page = 1
        self.isLast = false
    }
    
    func update(isLast: Bool) {
        self.isLast = isLast
    }
    
    func bind(searchRequest handler: @escaping (SearchRequest?) -> Void) { self.searchRequestHandler = handler }
}
