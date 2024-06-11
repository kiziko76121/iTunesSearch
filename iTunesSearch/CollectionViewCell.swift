//
//  CollectionViewCell.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var artworkUrl100: UIImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var trackTimeMillis: UILabel!
    @IBOutlet weak var longDescription: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var play = false
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
