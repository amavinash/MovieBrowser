//
//  MovieDBServices.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation

protocol MovieDBServices {
    func searchMovies(success: @escaping((Data?)-> Void), failure: @escaping((Error?)-> Void))
    func getPosterImage(success: @escaping((Data?)-> Void), failure: @escaping((Error?)-> Void))
}
