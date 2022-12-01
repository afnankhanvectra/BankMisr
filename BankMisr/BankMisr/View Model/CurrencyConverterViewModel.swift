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
    
    private func initilzeCurrencyModel(){
        
        currencyModelArray.append(CurrencyModel(currencyId: 1, name: "Pakistani Rupees" , value: 0.1))
        currencyModelArray.append(CurrencyModel(currencyId: 2,name: "egyptian pound" , value: 0.2))
        currencyModelArray.append(CurrencyModel(currencyId: 3,name: "USA Dollar" , value: 4.0))
    }
    
    func getCurrencyListName() -> [String] {
        return currencyModelArray.map({$0.name})
    }
    
    func convertToCurrency(fromCurrency : Int , toCurrency : Int , value : Double ) -> Double {
        
        guard let fromCurrencyModel = currencyModelArray.filter({$0.currencyId == fromCurrency}).first else { return 0.0}
        guard let toCurrencyModel = currencyModelArray.filter({$0.currencyId == toCurrency}).first else { return 0.0}
        let answer = (toCurrencyModel.value *  value ) / Double(fromCurrencyModel.value )
        return answer
    }
    
    
    func getCurrencyId(fromName name : String) -> Int {
       return  currencyModelArray.filter({$0.name == name}).first!.currencyId
        
    }
    
}
