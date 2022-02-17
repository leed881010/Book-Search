//
//  NetworkError.swift
//  NetworkKit
//
//  Created by USER on 2022/02/18.
//

import UIKit

public struct NetworkError: Error {
    
    public let code: Int
    public let message: String
    
    init?(error: Error?) {
        guard let error = error else { return nil }
        self.code = (error as NSError).code
        self.message = error.localizedDescription
    }
    
    init(type: ErrorType) {
        self.code = 0
        self.message = type.message
    }
    
}

public extension NetworkError {
    
    enum ErrorType {
        case unknown
        case preconditionFailed(desc: String)
        
        var message: String {
            switch self {
            case .unknown:                          return "이유를 알 수 없습니다."
            case .preconditionFailed(let desc):     return "\(desc) 실패"
            }
        }
    }
}
