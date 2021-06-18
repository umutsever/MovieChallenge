//
//  CastDetailViewController.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import UIKit
import SDWebImage

class CastDetailViewController: UIViewController {
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castBiography: UILabel!
    @IBOutlet weak var creditsCollection: UICollectionView!
    @IBOutlet weak var castName: UILabel!
    
    var castDetails = [SelectedCast]()
    var movieList = [CreditsList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        creditsCollection.dataSource = self
        creditsCollection.register(UINib(nibName: Constants.castCollectionViewCellClass, bundle: .main), forCellWithReuseIdentifier: Constants.castCollectionCell)
        
        prepareUI()
        getCastCredits()
        getCastBio()
    }
    
    
    //MARK: - Main Functions
    func prepareUI() {
        castImage.layer.cornerRadius = 13
        castImage.layer.shadowRadius = 3.0
        castImage.layer.shadowColor = UIColor.black.cgColor
        castImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        castImage.layer.shadowOpacity = 1
        
        castImage.sd_setImage(with: URL(string: castDetails[0].image), placeholderImage: UIImage(named: "placeholder.png"))
        castName.text = castDetails[0].name
    }
    
    func getCastCredits() {
        CastDetailService.shared.getCastsMovies(castID: "\(castDetails[0].id)") { (credits) in
            if let credits = credits {
                for i in credits.cast where i.poster_path != nil {
                    self.movieList.append(CreditsList(movieImage: "https://image.tmdb.org/t/p/w92" + i.poster_path!, movieName: i.title))
                }
                DispatchQueue.main.async {
                    self.creditsCollection.reloadData()
                }
            }
        }
    }
    
    
    func getCastBio() {
        CastDetailService.shared.getCastBio(castID: "\(castDetails[0].id)") { (bio) in
            if let bio = bio {
                DispatchQueue.main.async {
                    self.castBiography.text = bio.biography
                }
                
            }
            
        }
    }
    //MARK: - Segue
    @IBAction func backButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK: - CollectionView Datasource
extension CastDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.castCollectionCell, for: indexPath) as! CastCollectionViewCell
        cell.castName.text = movieList[indexPath.row].movieName
        cell.castImage.sd_setImage(with: URL(string: movieList[indexPath.row].movieImage), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    
    
}
