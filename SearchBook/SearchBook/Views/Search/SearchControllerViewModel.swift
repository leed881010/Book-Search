//
//  SearchControllerViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

protocol BookListTableViewModel: AnyObject {
    
    var numberOfRows: Int { get }
    var heightForRow: CGFloat { get }
    
    func book(for indexPath: IndexPath) -> SearchedBook
    func didSelectRow(at indexPath: IndexPath)
    func willDisplay(forRowAt indexPath: IndexPath)
}

protocol SearchControllerViewModelProtocol: AnyObject {
    
    var booksHandler: (([SearchedBook]) -> Void)? { get }
    func bind(books handler: @escaping ([SearchedBook]) -> Void)
}

final class SearchControllerViewModel {
    
    let searchTextFieldViewModel: SearchTextFieldViewModel = .init()
    
    init() {
        self.bind()
    }
    
    private var itbookAPIConnector: ItBookAPIConnectorProtocol { NetworkDispatcher.shared.itbookAPIConnector }
    private var books: [SearchedBook] = []
    private(set) var booksHandler: (([SearchedBook]) -> Void)?
    private(set) var pushableHandler: ((BaseNavigationViewModel.Pushable) -> Void)?
    private let searchFactorUpdater: SearchFactorUpdater = .init()
}

private extension SearchControllerViewModel {
    
    func update(newBooks: [SearchedBook]) {
        self.books.append(contentsOf: newBooks)
        self.booksHandler?(self.books)
    }
    
    func removeBooks() {
        self.books.removeAll()
        self.booksHandler?(self.books)
    }
    
    func fetch(search request: SearchRequest) {
        DispatchQueue.global(qos: .background).async {
            self.itbookAPIConnector.search(request: request) { [weak self] response, error in
                if let error = error {
                    print("error: \(error.message)")
                } else if let response = response {
                    let books = response.books.compactMap { SearchedBook(searchBook: $0) }
                    books.isEmpty ? self?.searchFactorUpdater.update(isLast: true) : self?.update(newBooks: books)
                } else {
                    self?.removeBooks()
                }
            }
        }
    }
}

private extension SearchControllerViewModel {
    
    func bind() {
        self.bind(searchFactorUpdater: self.searchFactorUpdater)
        self.bind(querySearchable: self.searchTextFieldViewModel)
    }
    
    func bind(querySearchable: QuerySearchable) {
        querySearchable.bind(query: self.receive(query:))
    }
    
    func bind(searchFactorUpdater: SearchFactorUpdaterProtocol) {
        searchFactorUpdater.bind(searchRequest: self.receive(searchRequest:))
    }
    
    func receive(searchRequest: SearchRequest?) {
        searchRequest.map { self.fetch(search: $0) }
    }
    
    func receive(query: String) {
        self.books.removeAll()
        self.searchFactorUpdater.update(query: query)
    }
    
}

extension SearchControllerViewModel: BookListTableViewModel {
    
    var numberOfRows: Int { self.books.count }
    var heightForRow: CGFloat { 120.0 }
    
    func book(for indexPath: IndexPath) -> SearchedBook {
        return self.books[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let book = self.book(for: indexPath)
        let viewModel: BookControllerViewModel = .init(initalData: BookControllerViewModel.InitialData(isbn13: book.isbn13))
        self.pushableHandler?(.book(viewModel))
    }
    
    func willDisplay(forRowAt indexPath: IndexPath) {
        guard indexPath.row + 1 == self.books.count else { return }
        self.searchFactorUpdater.next()
    }
}


extension SearchControllerViewModel: SearchControllerViewModelProtocol {
    
    func bind(books handler: @escaping ([SearchedBook]) -> Void) { self.booksHandler = handler }
}

extension SearchControllerViewModel: BaseNavigationPushableProtocol {
    
    func bind(pushable handler: @escaping (BaseNavigationViewModel.Pushable) -> Void) { self.pushableHandler = handler }
}
