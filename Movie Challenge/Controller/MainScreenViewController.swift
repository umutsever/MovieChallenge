//
//  ViewController.swift
//  Movie Challenge
//
//  Created by Umut Sever on 15.06.2021.
//

import UIKit
import SDWebImage


class MainScreenViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var selectedMovie = [MostPopularMovieList]()
    var mostPopularMovies = [MostPopularMovieList]()
    var filteredMovies = [MostPopularMovieList]()
    
    var segmentedTopic = "movie"
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: Constants.popularMovieCellClass, bundle: .main), forCellReuseIdentifier: Constants.popularMovieCellIdentifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        
        getMostPopularMovies()
        
        
    }

    
    
    
    //MARK: - Main Functions
    func getMostPopularMovies() {
        self.spinner.startAnimating()
        PopularMoviesService.shared.getPopularMovies { (movies) in
            if let movies = movies {
                for i in movies.results where i.poster_path != nil {
                    self.mostPopularMovies.append((MostPopularMovieList(overview: i.overview, posterImage:  "https://image.tmdb.org/t/p/w185" + i.poster_path!, title:  i.title, id: i.id, rating: i.vote_average)))
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                    
                }
            }
        }
        
    }
    
    func searchFunctionality(query: String) {
        filteredMovies.removeAll()
        self.spinner.startAnimating()
        if segmentedTopic == "movie" {
            SearchService.shared.getSearchedMovies(searchText: query) { (movies) in
                if let movies = movies {
                    for i in movies.results where i.poster_path != nil {
                        self.filteredMovies.append((MostPopularMovieList(overview: i.overview, posterImage:  "https://image.tmdb.org/t/p/w185" + i.poster_path!, title: i.title, id: i.id, rating: i.vote_average)))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                        
                    }
                }

            }
        } else if segmentedTopic == "tv" {
            SearchService.shared.getSearchedTV(searchText: query) { (movies) in
                if let movies = movies {
                    for i in movies.results where i.poster_path != nil {
                        self.filteredMovies.append((MostPopularMovieList(overview: i.overview, posterImage:  "https://image.tmdb.org/t/p/w185" + i.poster_path!, title: i.original_name, id: i.id, rating: i.vote_average)))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                        
                    }
                }

            }
            
        } else {
            SearchService.shared.getSearchedPerson(searchText: query) { (movies) in
                if let movies = movies {
                    for i in movies.results where i.profile_path != nil {
                        self.filteredMovies.append((MostPopularMovieList(overview: "", posterImage:  "https://image.tmdb.org/t/p/w185" + i.profile_path!, title: i.name, id: i.id, rating: 0.0)))
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.spinner.stopAnimating()
                        
                    }
                }

            }
        }
      
    }
    
    

    
    //MARK: - Segmented Control
    @IBAction func searchSegment(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            if searchBar.text != "" {
                segmentedTopic = "movie"
                searchFunctionality(query: searchBar.text!.replacingOccurrences(of: " ", with: "%20", options: .regularExpression))
            }
        case 1:
            if searchBar.text != "" {
                segmentedTopic = "person"
                searchFunctionality(query: searchBar.text!.replacingOccurrences(of: " ", with: "%20", options: .regularExpression))
            }
        case 2:
            if searchBar.text != "" {
                segmentedTopic = "tv"
                searchFunctionality(query: searchBar.text!.replacingOccurrences(of: " ", with: "%20", options: .regularExpression))
            }
        default:
            break;
        }
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToMovieDetailScreen {
            let secondVC = segue.destination as! MovieDetailViewController
            secondVC.movieDetails = selectedMovie
        }
    }
    
    
}


//MARK: - TableView Delegate and Datasource
extension MainScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredMovies.count > 0 {
            return filteredMovies.count
        } else {
            return mostPopularMovies.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.popularMovieCellIdentifier, for: indexPath) as! PopularMovieCells
        
        cell.selectionStyle = .none
        
        let movieList: MostPopularMovieList
        if filteredMovies.count > 0 {
            movieList = filteredMovies[indexPath.row]
        } else {
            movieList = mostPopularMovies[indexPath.row]
        }
        
        cell.movieTitle.text = movieList.title
        cell.movieSummary.text = movieList.overview
        cell.movieImage.sd_setImage(with: URL(string: movieList.posterImage), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if segmentedTopic != "person" {
            selectedMovie.removeAll()
            let movieList: MostPopularMovieList
            if filteredMovies.count > 0 {
                movieList = filteredMovies[indexPath.row]
            } else {
                movieList = mostPopularMovies[indexPath.row]
            }
            
            selectedMovie.append(MostPopularMovieList(overview: movieList.overview, posterImage: movieList.posterImage, title: movieList.title, id: movieList.id, rating: movieList.rating / 2))
            
            performSegue(withIdentifier: Constants.goToMovieDetailScreen, sender: self)
        }
      
    }
    
    
}



//MARK: - SearchBar Delegate
extension MainScreenViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" {
            DispatchQueue.main.async {
                self.filteredMovies.removeAll()
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        print("cancel clicked")
       
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if !searchBar.text!.isEmpty {
            searchFunctionality(query: searchBar.text!.replacingOccurrences(of: " ", with: "%20", options: .regularExpression))
        }
    }
    
}


