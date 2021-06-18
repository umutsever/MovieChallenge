//
//  Movies.swift
//  Movie Challenge
//
//  Created by Umut Sever on 15.06.2021.
//

import Foundation



struct MoviesModel: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let overview: String
    let poster_path: String?
    let title: String
    let id: Int
    let vote_average: Double
    
}

struct MostPopularMovieList {
    let overview: String
    let posterImage: String
    let title: String
    let id: Int
    let rating: Double
}

