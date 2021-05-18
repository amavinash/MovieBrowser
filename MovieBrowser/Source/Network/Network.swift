//
//  Network.swift
//  SampleApp
//
//  Created by Struzinski, Mark - Mark on 9/17/20.
//  Copyright © 2020 Lowe's Home Improvement. All rights reserved.
//

import UIKit
import Foundation


struct Network {
    static let baseURL = "api.themoviedb.org"
    static let imageBaseURL = "image.tmdb.org"
    static let apiKey = "5885c445eab51c7004916b9c0313e2d3"
    static let imageSize = "/w500"
    //https://image.tmdb.org/t/p/w500/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg
}

public protocol Endpoint{
    var baseURL: String { get }
    var path: String { get }
    var queryParameters: [String: String] { get }
}

public enum NetworkError: Error{
    case unknown
    case missingData
    case serialization
    case invalidData
    case invalidRequest
}

public enum NetworkResult{
    case success(Data?, URLResponse?)
    case failure(NetworkError, URLResponse?)
}

public enum imageSize: String{
    case optimum = "w500"
    case original = "original"
}

