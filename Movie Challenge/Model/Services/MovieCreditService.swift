//
//  MovieCreditService.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation


class MovieCreditService {
    
    static let shared = MovieCreditService()
    
    
    
    func getCreditsDetails(movieID: String, completion: @escaping (CreditsModel?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/credits?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-U")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
               
                    let creditsArray = try? JSONDecoder().decode(CreditsModel.self, from: data)
                    
                if let creditsArray = creditsArray {
                    completion(creditsArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
}
