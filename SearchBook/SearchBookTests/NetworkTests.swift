//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by USER on 2022/02/18.
//

import XCTest
@testable import SearchBook

class NetworkTests: XCTestCase {
    
    let networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()
    lazy var itBookAPIConnector: ItBookAPIConnectorProtocol = self.networkDispatcher.itbookAPIConnector
    
    override func setUpWithError() throws {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testSearchAPICallGetsComplete() throws {
        let searchRequest: SearchRequest = .init(query: "test", page: 1)
        var searchResponse: SearchResponse?
        var networkError: NetworkError?
        let promise = expectation(description: "Complete")
        self.itBookAPIConnector.search(request: searchRequest) { response, error in
            searchResponse = response
            networkError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(searchResponse)
        XCTAssertNil(networkError)
    }
    
    func testBooksAPICallGetsComplete() throws {
        let booksRequest: BooksReqeust = .init(isbn13: "9780131495050")
        var booksResponse: BooksResponse?
        var networkError: NetworkError?
        let promise = expectation(description: "Complete")
        self.itBookAPIConnector.books(request: booksRequest) { response, error in
            booksResponse = response
            networkError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(booksResponse)
        XCTAssertNil(networkError)
    }

    
    func testBooksAPICallGetsError() throws {
        let booksRequest: BooksReqeust = .init(isbn13: "failCase")
        var booksResponse: BooksResponse?
        var networkError: NetworkError?
        let promise = expectation(description: "Complete")
        self.itBookAPIConnector.books(request: booksRequest) { response, error in
            booksResponse = response
            networkError = error
            promise.fulfill()
        }
        wait(for: [promise], timeout: 5)
        XCTAssertNil(booksResponse)
        XCTAssertNotNil(networkError)
    }

}
