//
//  CastCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castName: UILabel!
    @IBOutlet weak var castImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        castImage.layer.cornerRadius = 13
        castImage.layer.shadowRadius = 3.0
        castImage.layer.shadowColor = UIColor.black.cgColor
        castImage.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        castImage.layer.shadowOpacity = 1
    }

}
