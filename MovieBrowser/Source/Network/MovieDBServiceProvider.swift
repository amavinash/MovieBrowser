//
//  MovieDBServiceProvider.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

class MovieDBServiceProvider: MovieDBServices {
    
    private let networkAdapter: NetworkAdapter
    private let endpoint: MovieDBEndPoints
    
    required init(networkAdapter:NetworkAdapter, endpoint: MovieDBEndPoints) {
        self.networkAdapter = networkAdapter
        self.endpoint = endpoint
    }
    
    func searchMovies(success: @escaping ((Data?) -> Void), failure: @escaping ((Error?) -> Void)) {
        networkAdapter.sendRequest(to: endpoint) { (result) in
            switch result{
            case let .success(data, _):
                if let data = data{
                    success(data)
                } else{
                    failure(NetworkError.missingData)
                }
            case let .failure(error, _):
                failure(error)
            }
        }
    }
    
    func getPosterImage(success: @escaping ((Data?) -> Void), failure: @escaping ((Error?) -> Void)) {
        networkAdapter.sendRequest(to: endpoint) { (result) in
            switch result{
            case let .success(data, _):
                if let data = data{
                    success(data)
                } else{
                    failure(NetworkError.missingData)
                }
            case let .failure(error, _):
                failure(error)
            }
        }
    }
}
