//
//  MovieDBEndPoints.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

enum MovieDBEndPoints: Endpoint {
    case searchMovie(searchText: String)
    case getMovieDetails(posterSize:String, posterPath: String)
    
    var baseURL: String {
        switch self {
        case .searchMovie:
            return Network.baseURL
        case .getMovieDetails:
            return Network.imageBaseURL
        }
    }
    
    
    var path: String {
        switch self {
        case .searchMovie:
            return "/3/search/movie"
        case .getMovieDetails(let posterSize, let posterPath):
            return "/t/p"+posterSize+posterPath
        }
    }
    
    var queryParameters: [String : String] {
        
        var defaultParameters = [String: String]()
        var localParameters = [String: String]()
        
        //defaultParameters = ["api_key":  Network.apiKey]
        
        switch self {
        case .searchMovie(let text):
            localParameters = ["query":text, "api_key":  Network.apiKey]
        case .getMovieDetails:
            return defaultParameters
        }
        return defaultParameters.merging(localParameters) {(_, new) in new }
    }
}
