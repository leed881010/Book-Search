//
//  ItBookAPI.swift
//  SearchBook
//
//  Created by USER on 2022/02/18.
//

import Foundation

enum ItBookAPI: NetworkAPI {
    
    case search(request: SearchRequest)
    case books(request: BooksReqeust)
}

extension ItBookAPI {
    
    var urlString: String { self.domain + self.path + self.pathParam }
    var domain: String { "https://api.itbook.store" }
    var path: String {
        switch self {
        case .search:   return "/1.0/search"
        case .books:    return "/1.0/books"
        }
    }
    
    var pathParam: String {
        switch self {
        case .search(let request):    return "/\(request.query)/\(request.page)"
        case .books(let request):    return "/\(request.isbn13)"
        }
    }
    
    var httpMethod: String {
        switch self {
        case    .search,
                .books:
            return HTTPMethod.get.value
        }
    }
}

enum HTTPMethod: String {
    case post, get, delete, patch
    var value: String { self.rawValue.uppercased() }
}
