//
//  PosterCell.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 2/12/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {
    
    @IBOutlet weak var posterimageView: UIImageView!
    
    var movie: Movie! {
        willSet {
        }
        didSet {
            if movie !== oldValue {
                if (movie.posterURL != nil) {
                    posterimageView.af_setImage(withURL: movie.posterURL!)
                }
            }
        }
    }
}
