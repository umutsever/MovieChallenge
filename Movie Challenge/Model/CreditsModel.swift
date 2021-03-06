//
//  CreditsModel.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation




struct CreditsModel: Decodable {
    let cast: [Casts]
    
}

struct CastSearchModel: Decodable {
    let results: [Casts]
}

struct Casts: Decodable {
    let id: Int
    let name: String
    let profile_path: String?
}


struct SelectedCast {
    let image: String
    let name: String
    let id: Int
}
