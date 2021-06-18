//
//  CastDetailModel.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation


struct castBiography: Decodable {
    let biography: String
    
}

struct castCredit: Decodable {
    let cast: [Credits]
}

struct Credits: Decodable {
    let poster_path: String?
    let title: String
}


struct CreditsList {
    let movieImage: String
    let movieName: String
}
