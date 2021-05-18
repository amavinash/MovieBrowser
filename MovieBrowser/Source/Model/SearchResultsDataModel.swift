//
//  SearchResultsDataModel.swift
//  MovieBrowser
//
//  Created by Avi on 5/16/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

struct SearchResults: Codable {
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [MovieItem]
    
}

struct MovieItem: Codable {
    let backdrop_path: String?
    let id: Int
    let original_language: String
    let original_title: String
    let overview : String
//    "popularity": 54.231,
    let poster_path : String?
    let release_date: String
    let title: String
//    "video": false,
    let vote_average : Double
//    "vote_count": 15503
}
