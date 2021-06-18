//
//  CastDetailService.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation


class CastDetailService {
    
    static let shared = CastDetailService()
    
    func getCastsMovies(castID: String, completion: @escaping (castCredit?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/person/\(castID)/movie_credits?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                
                let castArray = try? JSONDecoder().decode(castCredit.self, from: data)
                
                if let castArray = castArray {
                    completion(castArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
    
    func getCastBio(castID: String, completion: @escaping (castBiography?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/person/\(castID)?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                
                let castBio = try? JSONDecoder().decode(castBiography.self, from: data)
                
                if let castBio = castBio {
                    completion(castBio)
                }
                
                
            }
            
        }.resume()
        
    }
    
    
}
