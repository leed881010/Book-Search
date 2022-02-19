//
//  BookListTableViewDataSource.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

class BookListTableViewDataSource: NSObject {
    
    init(viewModel: BookListTableViewModel) {
        self.viewModel = viewModel
    }
    
    private unowned let viewModel: BookListTableViewModel
}

extension BookListTableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeReusableCell(BookListTableViewCell.self, for: indexPath)
        cell.layoutFactor = BookListTableViewCell.LayoutFactor(book: self.viewModel.book(for: indexPath))
        return cell
    }
    
}
