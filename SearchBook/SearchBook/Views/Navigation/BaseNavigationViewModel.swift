//
//  BaseNavigationViewModel.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

protocol BaseNavigationViewModelProtocol: AnyObject {
    
    var rootViewModel: SearchControllerViewModel { get }
}

final class BaseNavigationViewModel: BaseNavigationViewModelProtocol {
    
    let rootViewModel: SearchControllerViewModel = .init()
    
    private var bookControllerViewModel: BookControllerViewModel? {
        didSet {
            self.didUpdate(bookControllerViewModel: self.bookControllerViewModel)
        }
    }
    
    private(set) var pushableHandler: ((BaseNavigationViewModel.Pushable) -> Void)?
    private(set) var popableHandler: ((BaseNavigationViewModel.Popable) -> Void)?
    
    init() {
        self.bind()
    }
}

private extension BaseNavigationViewModel {
    
    func didUpdate(bookControllerViewModel viewModel: BookControllerViewModel?) {
        if let viewModel = self.bookControllerViewModel {
            self.pushableHandler?(.book(viewModel))
            viewModel.bind(popable: self.receive(popable:))
        } else {
            self.popableHandler?(.book)
        }
    }
}

private extension BaseNavigationViewModel {
    
    func bind() {
        self.bind(pushable: self.rootViewModel)
    }
    
    func bind(pushable: BaseNavigationPushableProtocol) {
        pushable.bind(pushable: self.receive(pushable:))
    }
    
    func receive(pushable: Pushable) {
        switch pushable {
        case .book(let viewModel): self.bookControllerViewModel = viewModel
        }
    }
    
    func receive(popable: Popable) {
        self.popableHandler?(popable)
    }
}

extension BaseNavigationViewModel: BaseNavigationPushableProtocol {
    
    func bind(pushable handler: @escaping (BaseNavigationViewModel.Pushable) -> Void) { self.pushableHandler = handler }
    
    enum Pushable {
        case book(BookControllerViewModel)
    }
}

extension BaseNavigationViewModel: BaseNavigationPopableProtocol {
    
    func bind(popable handler: @escaping (BaseNavigationViewModel.Popable) -> Void) { self.popableHandler = handler }
    
    enum Popable {
        case book
    }
}
