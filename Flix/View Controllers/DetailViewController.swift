//
//  DetailViewController.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/9/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var movie: Movie?
    var trailers: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        if let movie = movie {
            titleLabel.text = movie.title
            releaseDateLabel.text = movie.releaseDate
            overviewTextView.text = movie.overview
            let scoreVal = movie.scoreVal
            scoreLabel.text = String(describing: scoreVal) + "/10"
            
            if (scoreVal >= 7) {
                scoreLabel.textColor = UIColor.green
            }
            
            else if (scoreVal >= 5 && scoreVal < 7) {
                scoreLabel.textColor = UIColor.orange
            }
            
            else {
                scoreLabel.textColor = UIColor.red
            }
            
            if (movie.backdropURL != nil) {
                backDropImageView.af_setImage(withURL: movie.backdropURL!)
            }
            
            if (movie.posterURL != nil) {
                posterImageView.af_setImage(withURL: movie.posterURL!)
            }
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
