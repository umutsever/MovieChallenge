//
//  PopularMovieCells.swift
//  Movie Challenge
//
//  Created by Umut Sever on 15.06.2021.
//

import UIKit

class PopularMovieCells: UITableViewCell {
    
    @IBOutlet weak var bgView: UIView!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieSummary: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        movieImage.layer.cornerRadius = 7
        movieImage.layer.shadowRadius = 1.0
        movieImage.layer.shadowColor = UIColor.black.cgColor
        movieImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        movieImage.layer.shadowOpacity = 0.5
        
        

        bgView.layer.cornerRadius = 5
        bgView.layer.shadowRadius = 1.0
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        bgView.layer.shadowOpacity = 0.5
    }
    
}
