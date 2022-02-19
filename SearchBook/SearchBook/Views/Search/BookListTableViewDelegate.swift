//
//  BookListTableViewDelegate.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

class BookListTableViewDelegate: NSObject {

    init(viewModel: BookListTableViewModel) {
        self.viewModel = viewModel
    }

    private unowned let viewModel: BookListTableViewModel
}

extension BookListTableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectRow(at: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewModel.willDisplay(forRowAt: indexPath)
    }
}
