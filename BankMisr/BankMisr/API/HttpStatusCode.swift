//
//  HttpStatusCode.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

enum HttpStatusCode: Int32, Codable {
    case OK = 200
    case BadRequest = 400
    case InternalServerError = 500
    case Unknown = 1000
    case Timeout = -1001
    case TokenExpired = 104
    case INTERNAL_ERROR_CODE = 101
    case UNAUTHORIZED_ACCESS_CODE = 102
}
