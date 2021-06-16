//
//  MovieVideoService.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import Foundation

class MovieVideoService {
    
    static let shared = MovieVideoService()
    
   
    
    func getPopularMovies(videoID: String, completion: @escaping (VideoModel?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/movie/\(videoID)/videos?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-U")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
               
                let videoArray = try? JSONDecoder().decode(VideoModel.self, from: data)
                    
                if let videoArray = videoArray {
                    completion(videoArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
   
    
    
}
