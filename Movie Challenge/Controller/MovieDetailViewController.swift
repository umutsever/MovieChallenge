//
//  MovieDetailViewController.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import UIKit
import Cosmos
import SDWebImage
import youtube_ios_player_helper

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var summaryText: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    var videosList = [VideoList]()
    var selectedCast = [SelectedCast]()
    var displayedCast = [SelectedCast]()
    var movieDetails = [MostPopularMovieList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        castCollectionView.register(UINib(nibName: Constants.castCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.castCollectionCell)
        videoCollectionView.register(UINib(nibName: Constants.videoCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.videoCollectionCell)
        videoCollectionView.dataSource = self
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        
        prepareUI()
        getCredits()
        getVideos()
        
    }
    
    
    
    
    //MARK: - Main Functions
    func getCredits() {
        if movieDetails.count > 0 {
            MovieCreditService.shared.getCreditsDetails(movieID: "\(movieDetails[0].id)") { (credits) in
                if let credits = credits {
                    for i in credits.cast where i.profile_path != nil {
                        self.displayedCast.append(SelectedCast(image: "https://image.tmdb.org/t/p/w185" + i.profile_path!, name: i.name, id: i.id))
                    }
                    DispatchQueue.main.async {
                        self.castCollectionView.reloadData()
                    }
                }
            }
        }
        
        
    }
    
    func getVideos() {
        if movieDetails.count > 0 {
            self.spinner.startAnimating()
            MovieVideoService.shared.getPopularMovies(videoID: "\(movieDetails[0].id)") { (videos) in
                if let videos = videos {
                    for i in videos.results where i.site == "YouTube" {
                        self.videosList.append(VideoList(key: i.key, site: i.site))
                    }
                    DispatchQueue.main.async {
                        self.videoCollectionView.reloadData()
                        self.spinner.stopAnimating()
                    }
                }
            }
        }
    }
    
    
    func prepareUI() {
        
        starRating.settings.fillMode = .precise
        
        //Poster Image Configuration
        posterImage.layer.cornerRadius = 13
        posterImage.layer.shadowRadius = 3.0
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        posterImage.layer.shadowOpacity = 1
        
        if movieDetails.count != 0 {
            movieTitle.text = movieDetails[0].title
            starRating.rating = movieDetails[0].rating
            summaryText.text = movieDetails[0].overview
            posterImage.sd_setImage(with: URL(string: movieDetails[0].posterImage), placeholderImage: UIImage(named: "placeholder.png"))
        }
    }
    
    //MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.goToCastDetailScreen {
            let secondVC = segue.destination as! CastDetailViewController
            secondVC.castDetails = selectedCast
        }
    }


    @IBAction func backToMainButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.backToMainScreen, sender: self)
    }

}


//MARK: - CollectionView Delegate and Datasource
extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case castCollectionView:
            return displayedCast.count
        case videoCollectionView:
            return videosList.count
        default:
            fatalError("Invalid collectionView")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        
        case castCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCell, for: indexPath) as! CastCollectionViewCell
            cell.castName.text = displayedCast[indexPath.row].name
            cell.castImage.sd_setImage(with: URL(string: displayedCast[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        case videoCollectionView:
            let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.videoCollectionCell, for: indexPath) as! VideoCollectionViewCell
            cell.videoView.load(withVideoId: videosList[indexPath.row].key)
            return cell
            
        default:
            fatalError("Invalid collectionView")
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCast.removeAll()
        selectedCast.append(SelectedCast(image: displayedCast[indexPath.row].image, name: displayedCast[indexPath.row].name, id: displayedCast[indexPath.row].id))
        
        performSegue(withIdentifier: Constants.goToCastDetailScreen, sender: self)
    }
}


