//
//  Extension+UIViewController.swift
//  Movies
//
//  Created by Naveen Kumar V on 20/02/23.
//

import Foundation
import UIKit
import Toast_Swift


var activityView: UIActivityIndicatorView?

extension UIViewController {
    
    // Show Acitvity Indicator
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        view.addSubview(activityView ?? UIView())
        activityView?.startAnimating()
    }
    
    // Hide Activity Indicator
    func hideActivityIndicator(){
        if let spinnerView = activityView {
            spinnerView.stopAnimating()
        }
    }
    
    func showMessgaeToast(text:String) {
        DispatchQueue.main.async {
            self.view.makeToast(text, duration: 3.0, position:.bottom)
        }
    }

}
