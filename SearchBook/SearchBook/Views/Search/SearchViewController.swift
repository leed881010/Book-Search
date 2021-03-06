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
        self.tableViewDelegate = .init(viewModel: viewModel)
        self.tableViewDataSource = .init(viewModel: viewModel)
        
        super.init(nibName: nil, bundle: nil)
        self.setupView()
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private unowned let viewModel: SearchControllerViewModelProtocol
    private let searchTextField: SearchTextField
    private lazy var tableView: UITableView = {
        let tableView: UITableView = .init()
        tableView.delegate = self.tableViewDelegate
        tableView.dataSource = self.tableViewDataSource
        tableView.register(BookListTableViewCell.self)
        return tableView
    }()
    
    private let tableViewDelegate: BookListTableViewDelegate
    private let tableViewDataSource: BookListTableViewDataSource
}


private extension SearchViewController {
    
    func bind() {
        self.viewModel.bind(books: self.receive(books:))
    }
    
    func receive(books: [SearchedBook]) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

private extension SearchViewController {
    
    func setupView() {
        self.view.backgroundColor = .white
        self.title = "검색 화면"
        [self.searchTextField, self.tableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        NSLayoutConstraint.activate([
            self.searchTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.searchTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.searchTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.searchTextField.heightAnchor.constraint(equalToConstant: 60.0),
            
            self.tableView.topAnchor.constraint(equalTo: self.searchTextField.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}
