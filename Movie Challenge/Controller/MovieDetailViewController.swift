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
    
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    var firstIndexNumber = 0
    var secondIndexNumber = 10
    
    var videosList = [VideoList]()
    var selectedCast = [SelectedCast]()
    var movieDetails = [MostPopularMovieList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        posterImage.layer.cornerRadius = 13
        posterImage.layer.shadowRadius = 3.0
        posterImage.layer.shadowColor = UIColor.black.cgColor
        posterImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        posterImage.layer.shadowOpacity = 1
        
        
        
        castCollectionView.register(UINib(nibName: Constants.castCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.castCollectionCell)
        
        videoCollectionView.register(UINib(nibName: Constants.videoCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.videoCollectionCell)
      
        videoCollectionView.dataSource = self
        castCollectionView.dataSource = self
        
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
                    self.castCollectionView.reloadData()
                }
            }
        }
        
        
    }
    
    func getVideos() {
        MovieVideoService.shared.getPopularMovies(videoID: "\(movieDetails[0].id)") { (videos) in
            if let videos = videos {
                for i in videos.results where i.site == "YouTube" {
                    self.videosList.append(VideoList(key: i.key, site: i.site))
                }
                DispatchQueue.main.async {
                    self.videoCollectionView.reloadData()
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
        
        switch collectionView {
        case castCollectionView:
            return selectedCast.count
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
            cell.castName.text = selectedCast[indexPath.row].name
            cell.castImage.sd_setImage(with: URL(string: selectedCast[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
            return cell
            
        case videoCollectionView:
            let cell = videoCollectionView.dequeueReusableCell(withReuseIdentifier: Constants.videoCollectionCell, for: indexPath) as! VideoCollectionViewCell
            cell.videoView.load(withVideoId: videosList[indexPath.row].key)
            return cell
            
        default:
            fatalError("Invalid collectionView")
        }

    }
    
    
    
}
