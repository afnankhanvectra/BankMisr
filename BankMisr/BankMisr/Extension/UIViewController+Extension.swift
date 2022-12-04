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
}
