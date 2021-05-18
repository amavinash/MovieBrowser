//
//  MovieSearchServiceTests.swift
//  MovieBrowserTests
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import XCTest
@testable import MovieBrowser

class MovieSearchServiceTests: XCTestCase {

    var mockNetworkAdapter: MockNetworkAdapter!
    
    override func setUpWithError() throws {
        mockNetworkAdapter = MockNetworkAdapter()
    }

    override func tearDownWithError() throws {
        mockNetworkAdapter = nil
    }
    
    func testSearchMovieSuccess() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        guard let expectedJSONData = self.readLocalFile(name: "response") else {
            XCTAssertFalse(false, "failed to load local json file ")
            return
        }
        mockNetworkAdapter.expectedJSONData = expectedJSONData
        let endpoint = MovieDBEndPoints.searchMovie(searchText: "Star Wars")
        let serviceProvider = MovieDBServiceProvider(networkAdapter: mockNetworkAdapter, endpoint: endpoint)
        
        var isSuccessCalled = false
        let expectation = XCTestExpectation(description: "Search movies with text")
        
        serviceProvider.searchMovies { (data) in
            if let _ = data {
                isSuccessCalled = true
            }
            expectation.fulfill()
        } failure: { (_) in
            isSuccessCalled = false
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(isSuccessCalled, "Service request success")
    }
    
    func testSearchMovieFailure() throws {
        
        mockNetworkAdapter.expectedJSONData = nil
        let endpoint = MovieDBEndPoints.searchMovie(searchText: "Star Wars")
        let serviceProvider = MovieDBServiceProvider(networkAdapter: mockNetworkAdapter, endpoint: endpoint)
        
        var isSuccessCalled = false
        let expectation = XCTestExpectation(description: "Search movies with text")
        
        serviceProvider.searchMovies { (_) in
            isSuccessCalled = true
            expectation.fulfill()
        } failure: { (_) in
            isSuccessCalled = false
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(isSuccessCalled, "Service request success")
    }

    private func readLocalFile(name: String ) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
}
