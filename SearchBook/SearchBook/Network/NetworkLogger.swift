//
//  NetworkLogger.swift
//  SearchBook
//
//  Created by USER on 2022/02/18.
//

import Foundation

final class NetWorkLogger {
    
    static func printOut(response: URLResponse?, data: Data?, error: Error?) {
        var printStringArray:[String] = []
        printStringArray.append("----------------------------------------------------\n")
        let statusCode = (response as? HTTPURLResponse)?.statusCode
        let isSuccess = statusCode == 200 || statusCode == 204 ? "🎉 isSuccess" : "🧨 isFailed"
        printStringArray.append("[URLResponse]  \(isSuccess)")
        printStringArray.append("URL) \(response?.url?.absoluteString ?? "")")
        if let error = error {
            printStringArray.append("ERROR) \(error.localizedDescription)")
        }
        if let data = data,
           let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            printStringArray.append("DATA)\n\(jsonData)")
        }
        printStringArray.append("\n----------------------------------------------------")
        printStringArray.forEach {
            print($0)
        }
    }
    
    static func printOut(request: URLRequest?) {
        guard let request = request else { return }
        
        var printStringArray:[String] = []
        printStringArray.append("----------------------------------------------------\n")
        printStringArray.append("[URLRequest] ")
        printStringArray.append("URL) [\(request.httpMethod ?? "")] \(request.url?.absoluteString ?? "")")
        printStringArray.append("Header)")
        request.allHTTPHeaderFields?.forEach({ (key, value) in
            printStringArray.append("\(key): \(value)")
        })
        if let body = request.httpBody,
           let jsonData = try? JSONSerialization.jsonObject(with: body, options: []) as? [String: Any] {
            printStringArray.append("Body)\n\(jsonData)")
            
            if let objectData = jsonData["data"] as? Data,
               let jsonData = try? JSONSerialization.jsonObject(with: objectData, options: []) as? [String: Any]{
                printStringArray.append("BodyObject)\n\(jsonData)")
            }
        }
        
        printStringArray.append("\n----------------------------------------------------")
        printStringArray.forEach {
            print($0)
        }
    }
}
