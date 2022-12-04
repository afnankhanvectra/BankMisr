//
//  UIView+Extension.swift
//  BankMisr
//
//  Created by Afnan Khan on 04/12/2022.
//

import UIKit

extension UIView {
    
    @objc func removeView() {
        removeFromSuperview()
    }
    
    func addOverlayBackground(with color: UIColor = UIColor.black.withAlphaComponent(0.7)) {
        let vw = UIView(frame: UIScreen.main.bounds)
        vw.backgroundColor = color
        vw.tag = 7856
        addSubview(vw)
    }
    
    func removeOverlayBackgroud() {
        viewWithTag(7856)?.removeView()
    }
    
    func springAnimation() {
        transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 6.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
            self?.transform = .identity
        },
                       completion: nil)
    }
    
}
