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
    
    init?(error: Error?, response: URLResponse?, errorResponse: ErrorResponse?) {
        if let error = error {
            self.code = (error as NSError).code
            self.message = error.localizedDescription
            
        } else if let errorResponse = errorResponse,
                  let code = Int(errorResponse.error),
                  code != 0 {
            self.code = code
            self.message = "NetworkResponse include Error"
            
        } else if let response = response,
                  let statusCode = (response as? HTTPURLResponse)?.statusCode,
                  !(statusCode == 200 || statusCode == 204) {
            self.code = 0
            self.message = "NetworkResponse statusCode \(statusCode)"
            
        } else {
            return nil
        }
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
