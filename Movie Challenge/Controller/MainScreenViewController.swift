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
    
    var selectedMovie = [MostPopularMovieList]()
    var mostPopularMovies = [MostPopularMovieList]()
    var firstIndexNumber = 0
    var secondIndexNumber = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                    self.mostPopularMovies.append((MostPopularMovieList(overview: movies.results[i].overview, posterImage:  "https://image.tmdb.org/t/p/w185" + movies.results[i].poster_path, title:  movies.results[i].title, id: movies.results[i].id, rating: movies.results[i].vote_average)))
                    
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToMovieDetailScreen {
            let secondVC = segue.destination as! MovieDetailViewController
            secondVC.movieDetails = selectedMovie
        }
    }
    
    //VC Ends Here
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
        cell.movieImage.sd_setImage(with: URL(string: mostPopularMovies[indexPath.row].posterImage), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }
    
    
}

extension MainScreenViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie.removeAll()
        selectedMovie.append(MostPopularMovieList(overview: mostPopularMovies[indexPath.row].overview, posterImage: mostPopularMovies[indexPath.row].posterImage, title: mostPopularMovies[indexPath.row].title, id: mostPopularMovies[indexPath.row].id, rating: mostPopularMovies[indexPath.row].rating / 2))
        
        performSegue(withIdentifier: Constants.goToMovieDetailScreen, sender: self)
    }
    
}



