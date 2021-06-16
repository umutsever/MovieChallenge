//
//  MovieDetailViewController.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import UIKit
import Cosmos
import SDWebImage

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var starRating: CosmosView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var summaryText: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    var firstIndexNumber = 0
    var secondIndexNumber = 10
    
    var selectedCast = [SelectedCast]()
    var movieDetails = [MostPopularMovieList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        posterImage.layer.cornerRadius = 13
        posterImage.layer.shadowRadius = 3.0
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        posterImage.layer.shadowOpacity = 1
        
        
        
        collectionView.register(UINib(nibName: Constants.castCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.castCollectionCell)
      
        
        collectionView.dataSource = self
        print(movieDetails[0].id, "ID")
        starRating.settings.fillMode = .precise
        prepareUI()
        getCredits()
        getVideos()
    }
    
    
    
    
    func getCredits() {
        MovieCreditService.shared.getCreditsDetails(movieID: "\(movieDetails[0].id)") { (credits) in
            if let credits = credits {
                
                for i in credits.cast where i.profile_path != nil {
                    self.selectedCast.append(SelectedCast(image: "https://image.tmdb.org/t/p/w92" + i.profile_path!, name: i.name))
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
        
        
    }
    
    func getVideos() {
        MovieVideoService.shared.getPopularMovies(videoID: "\(movieDetails[0].id)") { (videos) in
            if let videos = videos {
                for i in videos.results where i.site == "YouTube" {
                    print(i)
                }
            }
        }
        
    }
    

    func prepareUI() {
        movieTitle.text = movieDetails[0].title
        starRating.rating = movieDetails[0].rating
        summaryText.text = movieDetails[0].overview
        posterImage.sd_setImage(with: URL(string: movieDetails[0].posterImage), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
    @IBAction func backToMainButton(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.backToMainScreen, sender: self)
    }
    
    
    
    
    
//VC Ends Here
}


extension MovieDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return selectedCast.count
            
        } else {
            return 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCell, for: indexPath) as! CastCollectionViewCell
        
        cell.castName.text = selectedCast[indexPath.row].name
        cell.castImage.sd_setImage(with: URL(string: selectedCast[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    
    
}
