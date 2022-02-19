//
//  SearchResponse.swift
//  NetworkKit
//
//  Created by USER on 2022/02/18.
//

import Foundation

struct SearchResponse: Decodable {
    
    let total: String
    let page: String
    let books: [SearchBook]
    
    enum CodingKeys: CodingKey {
        case error
        case total
        case page
        case books
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.total = try container.decode(String.self, forKey: .total)
        self.page = try container.decode(String.self, forKey: .page)
        self.books = try container.decode([SearchBook].self, forKey: .books)
    }
}

struct SearchBook: Decodable {
    
    let image: String
    let isbn13: String
    let price: String
    let subtitle: String
    let title: String
    let url: String
}

