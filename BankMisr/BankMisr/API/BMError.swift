//
//  BMError.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation
struct BMError: Error, Codable {
    var code: Int?
    var message: String?
    var Message: String?
    
    var toError: NSError {
        NSError(domain: "\(code)", code: code ?? 400, userInfo: ["message": message])
    }
    
    init(error: Error? = nil, desc: String? = nil) {
        code = 400
        message = "Error"
        if let error = error as NSError? {
            code = error.code
            message = error.localizedDescription
        } else if let desc = desc {
            message = desc
        }
    }
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}
