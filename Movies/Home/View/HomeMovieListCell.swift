//
//  HomeMovieListCell.swift
//  Movies
//
//  Created by Naveen Kumar V on 19/02/23.
//

import UIKit
import Kingfisher

protocol HomeMovieListCellDelegate: NSObjectProtocol {
    func tappedFavouriteImage(row: Int, cell: HomeMovieListCell)
}

class HomeMovieListCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var favouriteButton: UIButton!
    
    weak var homeMovieListCellDelegate: HomeMovieListCellDelegate?
    
    // Favourite button action
    @IBAction func favouriteButtonAction(_ sender: UIButton) {
        homeMovieListCellDelegate?.tappedFavouriteImage(row: sender.tag, cell: self)
    }
    
    func setUI(name: String, img: String) {
        DispatchQueue.main.async {
            let imageURLString = Constants.imagePath + img
            let url = URL(string: imageURLString)
            self.movieImage.kf.setImage(with: url)
            self.movieName.text = name
        }
    }
    
    // Update favourite image on button
    func updateFavouriteImage(isFavourite: Bool) {
        favouriteButton.setImage( UIImage(named: isFavourite ? Constants.selected : Constants.unSelected), for: .normal)
    }
}
