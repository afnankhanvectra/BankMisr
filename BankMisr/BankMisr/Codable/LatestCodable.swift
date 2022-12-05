//
//  LatestCodable.swift
//  BankMisr
//
//  Created by Afnan Khan on 04/12/2022.
//

import Foundation

struct LatestCodable: Codable {
    
    let base :      String
    let date :      String
    let success :   Bool
    let timestamp : Int64
    let rates :     [String : Double]
    
}

