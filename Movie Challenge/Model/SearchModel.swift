//
//  SearchModel.swift
//  Movie Challenge
//
//  Created by Umut Sever on 18.06.2021.
//

import Foundation


struct SearchModel: Decodable {
    let results: [SearchResult]
}

struct SearchResult: Decodable {
    let overview: String
    let poster_path: String?
    let original_name: String
    let id: Int
    let vote_average: Double 
}


