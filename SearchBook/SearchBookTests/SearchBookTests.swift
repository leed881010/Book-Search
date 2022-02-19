//
//  SearchBookTests.swift
//  SearchBookTests
//
//  Created by USER on 2022/02/18.
//

import XCTest
@testable import SearchBook

class SearchBookTests: XCTestCase {

    var searchControllerViewModel: SearchControllerViewModel!
    var searchTextFieldViewModel: SearchTextFieldViewModel!
    
    override func setUpWithError() throws {
        let controllerViewModel = SearchControllerViewModel()
        self.searchControllerViewModel = controllerViewModel
        self.searchTextFieldViewModel = controllerViewModel.searchTextFieldViewModel
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.searchControllerViewModel = nil
        self.searchTextFieldViewModel = nil
    }

    func testQueryWithBindingGetsBooks() {
        var result: [SearchedBook] = []
        let promise = expectation(description: "Complete")
        self.searchControllerViewModel.bind(books: {
            result = $0
            promise.fulfill()
        })
        self.searchTextFieldViewModel.action(.search("test"))
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
    }
    
    func testSearchFactorUpdaterNextGetsReqeust() {
        let searchFactorUpdator: SearchFactorUpdater = .init()
        var searchRequest: SearchRequest?
        let promise = expectation(description: "Complete")
        searchFactorUpdator.bind(searchRequest: {
            searchRequest = $0
            promise.fulfill()
        })
        searchFactorUpdator.next()
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(searchRequest?.page, 2)
    }
    
    func testSearchFactorUpdaterIsLastGetsRequestNil() {
        let searchFactorUpdator: SearchFactorUpdater = .init()
        var searchRequest: SearchRequest?
        let promise = expectation(description: "Complete")
        searchFactorUpdator.bind(searchRequest: {
            searchRequest = $0
            promise.fulfill()
        })
        searchFactorUpdator.update(isLast: true)
        searchFactorUpdator.next()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(searchRequest)
    }
    
    
}
