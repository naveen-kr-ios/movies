//
//  MovieViewController.swift
//  Movies
//
//  Created by Naveen Kumar V on 20/02/23.
//

import UIKit

class MovieViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    var movieDetail: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieTitle.text = movieDetail?.originalTitle
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        let attributeString = NSMutableAttributedString(string: movieDetail?.overview ?? "", attributes: attributes)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, attributeString.length))
        movieDescription.attributedText = attributeString
    }
    
}
