//
//  Double+Extension.swift
//  BankMisr
//
//  Created by Afnan Khan on 01/12/2022.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

