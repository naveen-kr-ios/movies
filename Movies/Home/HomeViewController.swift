//
//  HomeViewController.swift
//  Movies
//
//  Created by Naveen Kumar V on 19/02/23.
//

import UIKit
import Alamofire
import Foundation

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    let viewModel = MovieViewModel()
    var movieList: Movie?
    var englishMovieList: [Result]?
    var nonEnglishMovieList: [Result]?
    lazy var dbHandler: FavouriteMovieDBHandler = {
        return FavouriteMovieDBHandler.shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = Constants.movies
        // Display activity inidicator
        showActivityIndicator()
        fetchMovieList()
    }
    
    // Get the Movie
    func fetchMovieList() {
        viewModel.fetchMovieList { [weak self] responseData, error in
            guard let `self` = self else { return }
            // Hide activity inidicator
            self.hideActivityIndicator()
            if let response = responseData {
                self.movieList = response as? Movie
                self.setMovieData()
            }
            else {
                self.showMessgaeToast(text: error?.localizedDescription ?? Constants.tryAfterSomeTime)
            }
        }
    }
    
    func setMovieData() {
        englishMovieList = self.movieList?.results.filter{ $0.originalLanguage == Constants.en }
        nonEnglishMovieList = self.movieList?.results.filter{ $0.originalLanguage != Constants.en }
        homeCollectionView.reloadData()
    }
    
    func navigateToMovieDetailsView(row: Int, isEnglish: Bool = true) {
        if let movieViewController = self.storyboard?.instantiateViewController(withIdentifier: Constants.movieViewController) as? MovieViewController {
            movieViewController.movieDetail = isEnglish ? englishMovieList?[row] : nonEnglishMovieList?[row]
            navigationController?.pushViewController(movieViewController, animated: true)
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return englishMovieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/3.4, height: (collectionView.frame.size.width/3.4))
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // Banner view to display the non english movies
        guard let bannerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.homeBannerView, for: indexPath) as? HomeBannerView
        else { return UICollectionReusableView() }
        bannerView.movieArray = nonEnglishMovieList
        bannerView.pageControl.numberOfPages = nonEnglishMovieList?.count ?? 0
        bannerView.homeBannerViewDelegate = self
        bannerView.bannerCollectionView.reloadData()
        return bannerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.homeListCell, for: indexPath) as? HomeMovieListCell
        else { return UICollectionViewCell() }
        cell.layer.borderWidth = 0.3
        cell.layer.borderColor = UIColor.gray.cgColor
        cell.layer.cornerRadius = 2
        cell.favouriteButton.tag = indexPath.row
        cell.homeMovieListCellDelegate = self
        cell.updateFavouriteImage(isFavourite: dbHandler.isFavourite(englishMovieList?[indexPath.row].id ?? 0))
        cell.setUI(name: englishMovieList?[indexPath.row].title ?? "", img: englishMovieList?[indexPath.row].posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigateToMovieDetailsView(row: indexPath.row)
    }
}

extension HomeViewController: HomeBannerViewDelegate {
    
    func tappedBannerImage(row: Int) {
        navigateToMovieDetailsView(row: row, isEnglish: false)
    }
}

extension HomeViewController: HomeMovieListCellDelegate {
    
    func tappedFavouriteImage(row: Int, cell: HomeMovieListCell) {
        if dbHandler.isFavourite(englishMovieList?[row].id ?? 0) {
            dbHandler.removeFavoutire(englishMovieList?[row].id ?? 0)
        }
        else {
            dbHandler.addFavourite(englishMovieList?[row].id ?? 0)
        }
        cell.updateFavouriteImage(isFavourite: dbHandler.isFavourite(englishMovieList?[row].id ?? 0))
    }
}

