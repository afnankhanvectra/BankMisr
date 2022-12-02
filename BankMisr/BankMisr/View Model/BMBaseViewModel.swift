//
//  BMBaseViewModel.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

class BMBaseViewModel {
    
    let repository: RepositoryProtocol

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    

}
