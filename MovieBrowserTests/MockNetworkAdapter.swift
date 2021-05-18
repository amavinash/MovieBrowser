//
//  MockNetworkAdapter.swift
//  MovieBrowserTests
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
@testable import MovieBrowser

public class MockNetworkAdapter: NetworkAdapter {
    var expectedJSONData: Data?
    
    public override func sendRequest(to endpoint: Endpoint, completionHandler: @escaping (NetworkResult) -> Void) {
        if let jsondata = expectedJSONData {
            completionHandler(NetworkResult.success(jsondata, nil))
        } else {
            completionHandler(NetworkResult.failure(.missingData, nil))
        }
        
    }
}
