//
//  MovieCell.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/5/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movie: Movie! {
        willSet(newMovie) {
        }
        didSet(oldMovie) {
            if movie !== oldMovie {
                titleLabel.text = movie.title
                overviewTextView.text = movie.overview
                if movie.posterURL != nil {
                    posterImageView.af_setImage(withURL: movie.posterURL!)
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
