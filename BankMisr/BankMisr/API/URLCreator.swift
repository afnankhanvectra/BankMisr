//
//  URLCreator.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

struct URLCreator {
    
    static internal func getBaseURL() -> URL {
        
        return  URL(string:APIRoutes.getConfig.baseURL )!
    }
}
