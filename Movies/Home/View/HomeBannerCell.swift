//
//  HomeBannerCell.swift
//  Movies
//
//  Created by Naveen Kumar V on 19/02/23.
//

import UIKit
import Kingfisher

class HomeBannerCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var bannerImageWidthConstraint: NSLayoutConstraint!
    
    // Set banner image
    func setImage(img: String) {
        DispatchQueue.main.async {
            let imageURLString = Constants.imagePath + img
            let url = URL(string: imageURLString)
            self.bannerImage.kf.setImage(with: url)
        }
    }
}
