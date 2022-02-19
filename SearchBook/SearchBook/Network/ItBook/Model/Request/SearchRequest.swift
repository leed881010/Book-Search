//
//  SearchBookRequest.swift
//  NetworkKit
//
//  Created by USER on 2022/02/18.
//

import Foundation

struct SearchRequest {
    
    let query: String
    let page: Int
    
    init(query: String,
         page: Int) {
            self.query = query
            self.page = page
    }
    
    init(searchFactor: SearchControllerViewModel.SearchFactor) {
        self.query = searchFactor.query
        self.page = searchFactor.page
    }
}
