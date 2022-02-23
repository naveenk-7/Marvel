//
//  Extension+UIViewController.swift
//  Marvel
//
//  Created by Naveen Kumar on 23/02/22.
//

import Foundation
import UIKit

var activityView: UIActivityIndicatorView?

extension UIViewController {
    
    // Show Activity Indicator
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        view.addSubview(activityView ?? UIView())
        activityView?.startAnimating()
    }
    
    // Hide Activity Indicator
    func hideActivityIndicator() {
        if let spinnerView = activityView {
            spinnerView.stopAnimating()
        }
    }
}
