//
//  URLSessionConnector.swift
//  SearchBook
//
//  Created by USER on 2022/02/18.
//

import Foundation


protocol URLSessionConnectorProtocol {
    func dataTask<T: Decodable>(_ type: T.Type, urlRequest: URLRequest) -> (response: T?, error: NetworkError?)
}

final class URLSessionConnector: URLSessionConnectorProtocol {
    
    func dataTask<T: Decodable>(_ type: T.Type, urlRequest: URLRequest) -> (response: T?, error: NetworkError?) {
        NetWorkLogger.printOut(request: urlRequest)
        let lock = DispatchSemaphore(value: 0)
        var result: (response: T?, error: NetworkError?) = (nil, nil)
        URLSession(configuration: .default).dataTask(with: urlRequest) { (data, response, error) in
            NetWorkLogger.printOut(response: response, data: data, error: error)
            result.response = self.decodedData(data, type: T.self)
            result.error = NetworkError(error: error,
                                        response: response,
                                        errorResponse: self.decodedData(data, type: ErrorResponse.self))
            lock.signal()
        }.resume()
        lock.wait()
        return result
    }
}

private extension URLSessionConnector {
    
    func decodedData<T: Decodable>(_ data: Data?, type: T.Type) -> T? {
        guard let data = data else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
}
