//
//  DetailViewController.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/9/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit
enum MovieKeys {
    static let title = "title"
    static let releaseDate = "release_date"
    static let overview = "overview"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let score = "vote_average"
    
}

class DetailViewController: UIViewController {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var movie: [String: Any]?
    var trailers: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.releaseDate] as? String
            overviewTextView.text = movie[MovieKeys.overview] as? String
            let scoreVal = movie[MovieKeys.score] as! Double
            scoreLabel.text = String(describing: movie[MovieKeys.score]!) + "/10"
            
            if (scoreVal >= 7) {
                scoreLabel.textColor = UIColor.green
            }
            
            else if (scoreVal >= 5 && scoreVal < 7) {
                scoreLabel.textColor = UIColor.orange
            }
            
            else {
                scoreLabel.textColor = UIColor.red
            }
            
            let backdropPathString = movie[MovieKeys.backdropPath] as! String
            let posterPathString = movie[MovieKeys.posterPath] as! String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
            posterImageView.layer.borderWidth = 2
            posterImageView.layer.borderColor = UIColor.yellow.cgColor
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.onTap(gesture:)))
            backDropImageView.addGestureRecognizer(tapGesture)
            backDropImageView.isUserInteractionEnabled = true
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! TrailerViewController
        trailerViewController.movie = movie
    }
    
    @objc func onTap(gesture: UIGestureRecognizer) {
        performSegue(withIdentifier: "trailerSegue", sender: nil)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
