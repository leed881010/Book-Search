//
//  SearchViewController.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

final class SearchViewController: UIViewController {
    
    init(viewModel: SearchControllerViewModel) {
        self.viewModel = viewModel
        self.searchTextField = .init(viewModel: viewModel.searchTextFieldViewModel)
        super.init(nibName: nil, bundle: nil)
        self.setupView()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let viewModel: SearchControllerViewModelProtocol
    private let searchTextField: SearchTextField
    
}

private extension SearchViewController {
    
    func bind() {
        self.viewModel.bind(newBooks: self.receive(newBooks:))
    }
    
    func receive(newBooks: [Book]) {
        
    }
}

private extension SearchViewController {
    
    func setupView() {
        self.view.backgroundColor = .white
        self.title = "검색 화면"
        [self.searchTextField].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.searchTextField.heightAnchor.constraint(equalToConstant: 60.0),
        ])
    }
    
}
