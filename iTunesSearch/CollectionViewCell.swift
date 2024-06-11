//
//  CollectionViewCell.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//

import UIKit
import AVFoundation

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artworkUrl100: UIImageView!
    @IBOutlet weak var playArtworkUrl100: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var playTrackName: UILabel!
    @IBOutlet weak var trackTimeMillis: UILabel!
    @IBOutlet weak var playTrackTimeMillis: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var url: URL?
    var play = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func buttonTouch(_ sender: Any) {
        guard let url = self.url else{
            return
        }
        let player = AVPlayer()
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
