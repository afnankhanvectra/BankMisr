//
//  UIViewController+Extension.swift
//  BankMisr
//
//  Created by Afnan Khan on 04/12/2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String? = nil, message: String, completion: (() -> Void)? = nil) {
        
        let alertVc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
        }
        alertVc.addAction(okAction)
        present(alertVc, animated: true, completion: completion)
    }
    
    static func initialViewController(fromStoryboardNamed name: String, bundle: Bundle? = nil) -> UIViewController? {
        return UIStoryboard(name: name, bundle: bundle).instantiateInitialViewController()
    }
    
    static func instantiateViewController(identifier: String, fromStoryboardNamed name: String, bundle: Bundle? = nil) -> UIViewController? {
        return UIStoryboard(name: name, bundle: bundle).instantiateViewController(withIdentifier: identifier)
    }
}

protocol ViewControllerProvider {
    static func storyboard() -> String
}
extension ViewControllerProvider where Self: UIViewController  {
    static func storyboardId() -> String {
        return String(describing: self)
    }
    
    static func viewController() -> Self {
        guard let viewController = UIViewController.instantiateViewController(identifier: storyboardId(), fromStoryboardNamed: storyboard()) as? Self else {
            fatalError(
                "Failed to instantiate view controller with storyboard id \(storyboardId()) matching type \(type(of: Self.self)). "
                    + "Check that the storyboard id is set properly in your Storyboard "
                    + "and that you override the storyboard value"
            )
        }
        return viewController
    }
}

