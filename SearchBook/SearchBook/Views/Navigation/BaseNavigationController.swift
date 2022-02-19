//
//  BaseNavigationController.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    init(viewModel: BaseNavigationViewModel) {
        self.pushableViewModel = viewModel
        self.popableViewModel = viewModel
        let rootViewController: SearchViewController = .init(viewModel: viewModel.rootViewModel)
        self.rootViewController = rootViewController
        super.init(rootViewController: rootViewController)
        self.bind()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let rootViewController: SearchViewController
    private var bookViewController: BookViewController?
    
    private let pushableViewModel: BaseNavigationPushableProtocol
    private let popableViewModel: BaseNavigationPopableProtocol
}

private extension BaseNavigationController {
    
    func bind() {
        self.pushableViewModel.bind(pushable: self.receive(pushable:))
        self.popableViewModel.bind(popable: self.receive(popable:))
    }
    
    func receive(pushable: BaseNavigationViewModel.Pushable) {
        switch pushable {
        case .book(let viewModel): self.push(bookController: viewModel)
        }
    }
    
    func receive(popable: BaseNavigationViewModel.Popable) {
        switch popable {
        case .book: self.pop(bookController: popable)
        }
    }
}

private extension BaseNavigationController {
    
    func push(bookController viewModel: BookControllerViewModel) {
        guard self.bookViewController == nil else { return }
        self.bookViewController = .init(viewModel: viewModel)
        self.bookViewController.map { self.pushViewController($0, animated: true) }
    }
    
    func pop(bookController popable: BaseNavigationViewModel.Popable) {
        self.bookViewController?.navigationController?.popViewController(animated: true)
        self.transitionCoordinator?.animate(alongsideTransition: nil, completion: { [weak self] _ in
            self?.bookViewController = nil
        })
    }
}
