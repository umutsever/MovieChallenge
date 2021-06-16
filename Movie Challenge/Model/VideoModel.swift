//
//  VideoModel.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation


struct VideoModel: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let key: String
    let site: String
}

struct VideoList {
    let key: String
    let site: String
}
