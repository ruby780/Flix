//
//  Movie.swift
//  Flix
//
//  Created by Ruben A Gonzalez on 3/1/18.
//  Copyright © 2018 Ruben A Gonzalez. All rights reserved.
//

import Foundation
import AlamofireImage
enum MovieKeys {
    static let title = "title"
    static let releaseDate = "release_date"
    static let overview = "overview"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    static let score = "vote_average"
    static let id = "id"
}

class Movie {
    var title: String
    var releaseDate: String
    var overview: String
    var scoreVal: Double
    var id: NSNumber
    var posterURL: URL?
    var backdropURL: URL?
    
    init(dictionary: [String: Any]) {
        title = dictionary[MovieKeys.title] as? String ?? "No title"
        releaseDate = dictionary[MovieKeys.releaseDate] as? String ?? "No release date"
        overview = dictionary[MovieKeys.overview] as? String ?? "No overview"
        scoreVal = dictionary[MovieKeys.score] as? Double ?? 0
        id = dictionary[MovieKeys.id] as? NSNumber ?? 0
        
        let backdropPathString = dictionary[MovieKeys.backdropPath] as? String ?? ""
        let posterPathString = dictionary[MovieKeys.posterPath] as? String ?? ""
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        
        if posterPathString != "" {
            posterURL = URL(string: baseURLString + posterPathString)!
        }
        
        if backdropPathString != "" {
            backdropURL = URL(string: baseURLString + backdropPathString)!
        }
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
    
    
}
