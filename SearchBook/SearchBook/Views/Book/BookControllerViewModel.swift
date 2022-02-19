//
//  BookControllerViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol BookControllerViewModelProtocol: AnyObject {
    
    func action(type: BookControllerViewModel.ActionType)
    
    var bookHandler: ((Book) -> Void)? { get }
    func bind(book handler: @escaping(Book) -> Void)
    
    func fetchInitialData()
}

final class BookControllerViewModel {
    
    init(initalData: InitialData) {
        self.initialData = initalData
    }
    
    private let initialData: InitialData
    private var itbookAPIConnector: ItBookAPIConnectorProtocol { NetworkDispatcher.shared.itbookAPIConnector }
    private(set) var popableHandler: ((BaseNavigationViewModel.Popable) -> Void)?
    private(set) var bookHandler: ((Book) -> Void)?
}

extension BookControllerViewModel: BookControllerViewModelProtocol {
    
    func action(type: ActionType) {
        switch type {
        case .backNavigation:   self.popableHandler?(.book)
        }
    }
    
    func fetchInitialData() {
        DispatchQueue.global(qos: .background).async {
            self.itbookAPIConnector.books(request: BooksReqeust(isbn13: self.initialData.isbn13)) { [weak self] response, error in
                if let error = error {
                    print("error: \(error.message)")
                } else if let response = response,
                          let book: Book = .init(bookResponse: response) {
                    self?.bookHandler?(book)
                }
            }
        }
    }
    
    func bind(book handler: @escaping (Book) -> Void) { self.bookHandler = handler }
}

extension BookControllerViewModel: BaseNavigationPopableProtocol {
    
    func bind(popable handler: @escaping (BaseNavigationViewModel.Popable) -> Void) { self.popableHandler = handler }
}

extension BookControllerViewModel {
    
    struct InitialData {
        let isbn13: String
    }
    
    enum ActionType {
        case backNavigation
    }
}
