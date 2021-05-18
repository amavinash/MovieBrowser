//
//  SearchViewController.swift
//  SampleApp
//
//  Created by Struzinski, Mark on 2/19/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var movies:[MovieItem] = [MovieItem](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private let coordinator = MovieDBServiceCoordinator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()  {
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func searchButtonTapped(_ sender: Any) {
        guard let text = searchBar.text, text.count != 0 else {
            self.showAlert(with: "Alert", and: "Please enter movie name to start search.")
            return
        }
        sendSearchRequest(with: text)
    }
    
    func sendSearchRequest(with text:String) {
        coordinator.searchMovies(with: text) { (results) in
            if let results = results {
                self.movies = results.results
            } else {
                self.showAlert(with: "Error", and: "Search request failed.")
            }
        }
    }
    
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
    
}

//MARK: SearchBar delegate

extension SearchViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            sendSearchRequest(with: text)
        } else {
            self.showAlert(with: "Alert", and: "Please enter movie name to start search.")
        }
    }
}

//MARK: Tableview Delegate & Datasources
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieResultCell", for: indexPath) as? MovieResultTableViewCell else{
            return UITableViewCell()
        }
        cell.Configure(movies[indexPath.row])
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        showDetails(for: movies[indexPath.row])
    }
    
    private func showDetails(for movie: MovieItem) {
        guard let viewController = storyboard?.instantiateViewController(
            identifier: "MovieDetails",
            creator: { coder in
                MovieDetailViewController(movie: movie, coder: coder)
            }
        ) else {
            fatalError("Failed to create Product Details VC")
        }
        show(viewController, sender: self)
    }         
}



