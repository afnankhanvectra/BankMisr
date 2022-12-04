//
//  BMBaseViewModel.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

class BMBaseViewModel {
    
    let repository: RepositoryProtocol
    var onFinishWithError: StringCallBack?
    var onStartLoading: VoidCallBack?

    init(repository: RepositoryProtocol) {
        self.repository = repository
    }
    

    

}
