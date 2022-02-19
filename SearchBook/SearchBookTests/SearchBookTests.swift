//
//  SearchBookTests.swift
//  SearchBookTests
//
//  Created by USER on 2022/02/18.
//

import XCTest
@testable import SearchBook

class SearchBookTests: XCTestCase {

    var searchControllerViewModelProtocol: SearchControllerViewModelProtocol!
    var searchTextFieldViewModel: SearchTextFieldViewModelProtocol!
    
    override func setUpWithError() throws {
        let controllerViewModel = SearchControllerViewModel()
        self.searchControllerViewModelProtocol = controllerViewModel
        self.searchTextFieldViewModel = controllerViewModel.searchTextFieldViewModel
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.searchControllerViewModelProtocol = nil
        self.searchTextFieldViewModel = nil
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

    func testQueryWithBindingGetsBooks() {
        var result: [Book] = []
        let promise = expectation(description: "Complete")
        self.searchControllerViewModelProtocol.bind(newBooks: {
            result = $0
            promise.fulfill()
        })
        self.searchTextFieldViewModel.action(.search("test"))
        wait(for: [promise], timeout: 5)
        XCTAssertNotNil(result)
    }
    
    func testNewQueryWithBindingGetsIsNewTrue() {
        var isNew: Bool = false
        let promise = expectation(description: "Complete")
        self.searchControllerViewModelProtocol.bind(newSearchFactor: {
            isNew = $0.isNew
            promise.fulfill()
        })
        self.searchTextFieldViewModel.action(.search("test"))
        wait(for: [promise], timeout: 5)
        XCTAssertTrue(isNew)
    }
}
