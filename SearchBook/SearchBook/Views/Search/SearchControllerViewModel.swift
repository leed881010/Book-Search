//
//  SearchControllerViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol SearchControllerViewModelProtocol: AnyObject {
    
    var books: [Book] { get }
    
    var newBooksHandler: (([Book]) -> Void)? { get }
    func bind(newBooks handler: @escaping([Book]) -> Void)
}

final class SearchControllerViewModel {
    
    let searchTextFieldViewModel: SearchTextFieldViewModel = .init()
    
    init() {
        self.bind()
    }
    
    
    private var itbookAPIConnector: ItBookAPIConnectorProtocol { NetworkDispatcher.shared.itbookAPIConnector }
    private var searchFactor: SearchFactor? {
        didSet {
            self.searchFactor.map { self.search(factor: $0) }
        }
    }
    
    
    private(set) var books: [Book] = []
    private(set) var newBooksHandler: (([Book]) -> Void)?
}

private extension SearchControllerViewModel {
    
    func search(factor: SearchFactor) {
        let searchRequest: SearchRequest = .init(searchFactor: factor)
        self.itbookAPIConnector.search(request: searchRequest) { [weak self] response, error in
            if let error = error {
                
            } else if let response = response {
                let books = response.books.compactMap { Book(searchBook: $0) }
                self?.books.append(contentsOf: books)
                self?.newBooksHandler?(books)
            }
        }
    }
}

private extension SearchControllerViewModel {
    
    func bind() {
        self.bind(querySearchable: self.searchTextFieldViewModel)
    }
    
    func bind(querySearchable: QuerySearchable) {
        querySearchable.bind(query: self.receive(query:))
    }
    
    func receive(query: String) {
        self.searchFactor = SearchFactor(query: query)
    }
    
}

extension SearchControllerViewModel: SearchControllerViewModelProtocol {
    
    func bind(newBooks handler: @escaping ([Book]) -> Void) { self.newBooksHandler = handler }
}

extension SearchControllerViewModel {
    
    class SearchFactor {
        let query: String
        var page: Int
        
        init(query: String) {
            self.query = query
            self.page = 1
        }
        
        func update(page: Int) {
            self.page = page
        }
    }
}
