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
    
    var firstIndexNumber = 0
    var secondIndexNumber = 10
    
    var selectedCast = [SelectedCast]()
    var movieDetails = [MostPopularMovieList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        collectionView.register(UINib(nibName: Constants.castCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.castCollectionCell)
        
        print("ok")
        collectionView.dataSource = self
        print(movieDetails[0].id, "ID")
        starRating.settings.fillMode = .precise
        prepareUI()
        getCredits()
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
        return selectedCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCell, for: indexPath) as! CastCollectionViewCell
        
        cell.castName.text = selectedCast[indexPath.row].name
        cell.castImage.sd_setImage(with: URL(string: selectedCast[indexPath.row].image), placeholderImage: UIImage(named: "placeholder.png"))
        
        return cell
    }
    
    
    
}
