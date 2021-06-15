//
//  PopularMoviesService.swift
//  Movie Challenge
//
//  Created by Umut Sever on 15.06.2021.
//

import Foundation


class PopularMoviesService {
    
    static let shared = PopularMoviesService()
    
   
    
    func getPopularMovies(completion: @escaping (MoviesModel?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US&page=1")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
               
                    let movieArray = try? JSONDecoder().decode(MoviesModel.self, from: data)
                    
                if let movieArray = movieArray {
                    completion(movieArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
   
    
    
}
