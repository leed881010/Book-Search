//
//  NibLoadable.swift
//  SearchBook
//
//  Created by USER on 2022/02/19.
//

import Foundation

protocol NibLoadable: AnyObject {
    
    static var nibId: String { get }
}

extension NibLoadable {
    
    static var nibId: String { String(describing: self) }
    
}
