//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/5/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    var filteredData: [Movie] = []
    var refreshControl: UIRefreshControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.alpha = 0
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        searchBar.delegate = self
        
        // Set the height of the cells
        self.tableView.rowHeight = 190
        
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                if (self.movies.isEmpty){self.filteredData = movies}
                self.movies = movies
                self.tableView.reloadData()
            } else if let error = error {
                self.handleNetErrors(error: error)
            }
        }
        
        // Set the filtered Data to the complete movies dictionary
        filteredData = movies
    }
    
    // Refresh data function. Will call the function to fetch data
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        tableView.alpha = 0
        activityIndicator.startAnimating()
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            if let movies = movies {
                if (self.movies.isEmpty) {self.filteredData = movies}
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.tableView.alpha = 1
                self.activityIndicator.stopAnimating()
            } else if let error = error {
                self.handleNetErrors(error: error)
            }
        }
    }
    
    func handleNetErrors(error: Error!) {
        print(error.localizedDescription)
        
        // Create Network Error handler
        let alertController = UIAlertController(title: "Cannot Get Movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
        
        // create a Try Again action
        let TryAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
            // handle response here.
            self.didPullToRefresh(self.refreshControl)
        }
        // add the Try Again action to the alert controller
        alertController.addAction(TryAction)
        
        // Show error message
        self.present(alertController, animated: true) {}
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.movie = filteredData[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let movie = filteredData[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        filteredData = searchText.isEmpty ? movies : movies.filter { (item: Movie) -> Bool in
            
            // If dataItem matches the searchText, return true to include it
            return item.title.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
