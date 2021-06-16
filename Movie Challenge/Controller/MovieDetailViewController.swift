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
    
    
    var movieDetails = [MostPopularMovieList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ok")
        
        print(movieDetails[0].id, "ID")
        starRating.settings.fillMode = .precise
        prepareUI()
        getCredits()
    }
    
    
    
    
    func getCredits() {
        MovieCreditService.shared.getCreditsDetails(movieID: "\(movieDetails[0].id)") { (credits) in
            if let credits = credits {
                
                for i in credits.cast where i.profile_path != nil {
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
