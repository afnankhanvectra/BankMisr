//
//  BMBaseViewController.swift
//  BankMisr
//
//  Created by Afnan Khan on 04/12/2022.
//

import UIKit

class BMBaseViewController: UIViewController {
    
    var loadingProcessCount = 0
    var ignoreLoadingCount = true
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 100)))
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        
        return indicator
    }()
    
    
    func showLoadingIndicator(color : UIColor? = nil) {
        loadingProcessCount += 1
        guard !view.subviews.contains(activityIndicator) else { return }
        activityIndicator.startAnimating()
        if let color = color {
            activityIndicator.color = color
        } else {
            activityIndicator.color = .gray
        }
        view.addOverlayBackground(with: UIColor.black.withAlphaComponent(0.2))
        view.addSubview(activityIndicator)
    }
    
    func dismissLoadingIndicator() {
        loadingProcessCount -= 1
        if loadingProcessCount == 0 || ignoreLoadingCount {
            view.removeOverlayBackgroud()
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModelCallbacks()
    }
    
    func setupViewModelCallbacks() { }
    
}

