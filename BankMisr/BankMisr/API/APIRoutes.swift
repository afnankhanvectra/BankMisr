//
//  APIRoutes.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

enum APIRoutes: String {
        
    case getConfig = "config"

    var baseURL: String {
//        return "https://jsonplaceholder.typicode.com/"
        return "https://api.apilayer.com/fixer/"
    }
    
    var route: String {
        return baseURL + self.rawValue
    }
}
