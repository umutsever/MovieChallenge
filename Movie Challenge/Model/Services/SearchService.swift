//
//  SearchService.swift
//  Movie Challenge
//
//  Created by Umut Sever on 18.06.2021.
//

import Foundation


class SearchService {
    
    static let shared = SearchService()
    func getSearchedMovies(searchText: String,completion: @escaping (MoviesModel?) -> ()) {
        
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/movie?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US&query=\(searchText)&page=1&include_adult=false")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let searchArray = try? JSONDecoder().decode(MoviesModel.self, from: data)
                if let searchArray = searchArray {
                    completion(searchArray)
                }

            }
            
        }.resume()
        
    }

    func getSearchedTV(searchText: String, completion: @escaping (SearchModel?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/tv?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US&query=\(searchText)&page=1&include_adult=false")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let searchArray = try? JSONDecoder().decode(SearchModel.self, from: data)
                if let searchArray = searchArray {
                    completion(searchArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
    
    func getSearchedPerson(searchText: String, completion: @escaping (CastSearchModel?) -> ()) {
        URLSession.shared.dataTask(with: URL(string: "https://api.themoviedb.org/3/search/person?api_key=bc45a04ead6fd8e63685ebba047d9200&language=en-US&query=\(searchText)&page=1&include_adult=false")!) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let searchArray = try? JSONDecoder().decode(CastSearchModel.self, from: data)
                if let searchArray = searchArray {
                    completion(searchArray)
                }
                
                
            }
            
        }.resume()
        
    }
    
    
    
    
}
