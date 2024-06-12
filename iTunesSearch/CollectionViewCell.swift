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
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackTimeMillis: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var bottomView: UIView!
    var play = false
    var url: URL?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
