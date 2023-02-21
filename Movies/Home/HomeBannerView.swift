//
//  HomeBannerView.swift
//  Movies
//
//  Created by Naveen Kumar V on 19/02/23.
//

import UIKit

protocol HomeBannerViewDelegate: NSObjectProtocol {
    func tappedBannerImage(row: Int)
}


class HomeBannerView: UICollectionReusableView {
        
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var colorArray = [UIColor]()
    var movieArray: [Result]?
    weak var homeBannerViewDelegate: HomeBannerViewDelegate?
    
    @IBAction func pageControlAction(_ sender: UIPageControl) {
        bannerCollectionView.scrollToItem(at: IndexPath(row: pageControl.currentPage, section: 0), at: .left, animated: true)
    }
}

extension HomeBannerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeBannerCell, for: indexPath) as? HomeBannerCell
        else { return UICollectionViewCell() }
        cell.setImage(img: movieArray?[indexPath.row].posterPath ?? "")
        cell.bannerImageWidthConstraint.constant = collectionView.frame.size.width
        cell.bannerImage.layer.cornerRadius = 10
        cell.bannerImage.layoutIfNeeded()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        homeBannerViewDelegate?.tappedBannerImage(row: indexPath.row)
    }
    
    // Set current page for pagecontrol while scrolling banner image
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = scrollView.contentOffset.x / scrollView.frame.size.width
        self.pageControl.currentPage = Int(currentPage)
    }
}
