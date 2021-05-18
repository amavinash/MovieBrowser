//
//  MovieDetailViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/26/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    private let movieItem:MovieItem
    
    private let coordinator = MovieDBServiceCoordinator()
    
    init?(movie: MovieItem, coder: NSCoder) {
        self.movieItem = movie
        super.init(coder: coder)
    }
    
    @available(*, unavailable, renamed: "init(product:coder:)")
    required init?(coder: NSCoder) {
        fatalError("Invalid way of decoding this class")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = movieItem.title
        releaseDateLabel.text = movieItem.release_date
        overviewLabel.text = movieItem.overview
        self.getPosterImage()
    }
    
    func getPosterImage()  {
        guard let posterPath = movieItem.poster_path else { return  }
        coordinator.getPosterImage(for: posterPath) { (image) in
            if let image = image{
                DispatchQueue.main.async{
                    self.posterImage.image = image
                }
            }
        }
    }
}
