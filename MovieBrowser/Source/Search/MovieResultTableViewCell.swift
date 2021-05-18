//
//  MovieResultTableViewCell.swift
//  MovieBrowser
//
//  Created by Avi on 5/17/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieResultTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    
    func Configure(_ movie: MovieItem) {
        movieNameLabel.text = movie.original_title
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withYear,.withMonth,.withDay,.withDashSeparatorInDate]
        
        if let date = dateFormatter.date(from: movie.release_date) {
            releaseDateLabel.text = date.string(withFormat: "MMM dd, yyyy")
        } else {
            releaseDateLabel.text = movie.release_date
        }
        ratingsLabel.text = String(movie.vote_average)
    }
}
