//
//  ViewController.swift
//  Movie Challenge
//
//  Created by Umut Sever on 15.06.2021.
//

import UIKit
import SDWebImage


class MainScreenViewController: UIViewController {

    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var mostPopularMovies = [MostPopularMovieList]()
    var firstIndexNumber = 0
    var secondIndexNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ok")
        
        tableView.register(UINib(nibName: Constants.popularMovieCellClass, bundle: .main), forCellReuseIdentifier: Constants.popularMovieCellIdentifier)
      
        tableView.dataSource = self
        tableView.delegate = self
        getMostPopularMovies()
      
        
    }
    

    func getMostPopularMovies() {
        self.spinner.startAnimating()
        PopularMoviesService.shared.getPopularMovies { (movies) in
            if let movies = movies {
                for i in self.firstIndexNumber...self.secondIndexNumber {
                    self.mostPopularMovies.append((MostPopularMovieList(overview: movies.results[i].overview, posterImage:  movies.results[i].poster_path, title:  movies.results[i].title, id: movies.results[i].id, rating: movies.results[i].vote_average)))
                    
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.firstIndexNumber = self.secondIndexNumber + 1
                    self.secondIndexNumber = self.firstIndexNumber + 3
                    self.spinner.stopAnimating()
                    
                }
            }
        }
        
    }
    

}


extension MainScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mostPopularMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.popularMovieCellIdentifier, for: indexPath) as! PopularMovieCells
        cell.selectionStyle = .none
        
        cell.movieTitle.text = mostPopularMovies[indexPath.row].title
        cell.movieSummary.text = mostPopularMovies[indexPath.row].overview
        cell.movieImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w92" + mostPopularMovies[indexPath.row].posterImage), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }
    
    
}

extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(mostPopularMovies[indexPath.row].rating)
    }
    
}



