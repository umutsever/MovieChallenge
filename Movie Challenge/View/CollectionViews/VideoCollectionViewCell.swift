//
//  VideoCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Umut Sever on 16.06.2021.
//

import UIKit
import youtube_ios_player_helper

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var videoView: YTPlayerView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
