//
//  UITableView+.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import UIKit

extension UITableView {
    
    func register<T: UITableViewCell> (_ :T.Type) where T: NibLoadable {
        self.register(T.self, forCellReuseIdentifier: T.nibId)
    }
    
    func dequeReusableCell<T: UITableViewCell> (_ :T.Type, for indexPath: IndexPath) -> T where T : NibLoadable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.nibId, for: indexPath) as? T else {
            fatalError("Count not find \(T.nibId)")
        }
        
        return cell
    }
    
}
