//
//  CurrencyConverterViewModel.swift
//  BankMisr
//
//  Created by Afnan Khan on 30/11/2022.
//

import Foundation

class CurrencyConverterViewModel : NSObject {
    
    private var currencyModelArray = [CurrencyModel]()
    
    override init() {
            super.init()
        initilzeCurrencyModel()
    }

    func initilzeCurrencyModel(){
        
        currencyModelArray.append(CurrencyModel(currencyId: 1, name: "pkr" , value: 0.1))
        currencyModelArray.append(CurrencyModel(currencyId: 2,name: "ep" , value: 0.2))
        currencyModelArray.append(CurrencyModel(currencyId: 3,name: "eu" , value: 4.0))
    }
    
    func convertToCurrency(fromCurrency : Int , toCurrency : Int , value : Double ) -> Double {
        
        guard let fromCurrencyModel = currencyModelArray.filter({$0.currencyId == fromCurrency}).first else { return 0.0}
        guard let toCurrencyModel = currencyModelArray.filter({$0.currencyId == toCurrency}).first else { return 0.0}
        let answer = (toCurrencyModel.value *  value ) / Double(fromCurrencyModel.value )
        print("To and From currency model \(answer)")
        return answer
        
    }
    
    
}
