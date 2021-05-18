//
//  MovieDBServiceCoordinator.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

class MovieDBServiceCoordinator {
    
    func searchMovies(with title: String, completionHandler: @escaping(SearchResults?) -> Void) {
        let serviceProvider = MovieDBServiceProvider(networkAdapter: NetworkAdapter(), endpoint: .searchMovie(searchText: title))
        serviceProvider.searchMovies { (data) in
            if let data = data {
                do {
                    if let str = data.prettyPrintedJSON { print(str)}
                    let response:SearchResults = try JSONDecoder().decode(SearchResults.self, from: data)
                    completionHandler(response)
                } catch {
                    print(error)
                    completionHandler(nil)
                }
            }
        } failure: { (error) in
            completionHandler(nil)
        }
    }
    
    func getPosterImage(for path:String, completionHandler: @escaping ((UIImage?) -> Void)) {
        let serviceProvider = MovieDBServiceProvider(networkAdapter: NetworkAdapter(), endpoint: .getMovieDetails(posterSize: Network.imageSize, posterPath: path))
        serviceProvider.getPosterImage { (data) in
            if let data = data, let image = UIImage(data: data){
                completionHandler(image)
            } else {
                completionHandler(nil)
            }
        } failure: { (error) in
            completionHandler(nil)
        }
    }
}
