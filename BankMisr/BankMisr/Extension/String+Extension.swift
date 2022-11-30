//
//  String+Extension.swift
//  BankMisr
//
//  Created by Afnan Khan on 01/12/2022.
//

import Foundation


extension Optional where Wrapped == String {
    func isNil() -> Bool {
        return self == nil
    }
    func isNilOrEmpty() -> Bool {
        return self == nil || self == ""
    }
}
