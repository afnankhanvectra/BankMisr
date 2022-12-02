//
//  Repository.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

typealias GenericResult<T> = (Result<T, Error>) -> Void

protocol RepositoryProtocol {
}


class Repository: RepositoryProtocol {
    
    static let shared = Repository()

    private init() { }


}
