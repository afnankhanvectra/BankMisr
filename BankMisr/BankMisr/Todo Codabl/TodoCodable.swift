//
//  TodoCodeable.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

struct TodoCodable: Codable {
    let userId, id: Int
    let title : String
    let completed : Bool
}

