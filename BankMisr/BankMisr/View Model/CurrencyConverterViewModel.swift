//
//  CurrencyConverterViewModel.swift
//  BankMisr
//
//  Created by Afnan Khan on 30/11/2022.
//

import Foundation

class CurrencyConverterViewModel : BMBaseViewModel {
    
    private var currencyModelArray = [CurrencyModel]()
    var onFinishGetLatestCurrency: VoidCallBack?
    
    
    override init(repository: RepositoryProtocol) {
        super.init(repository: repository)
        //        initilzeCurrencyModel()
    }
    
    private func saveLatestCodabeValue(_ latestCodeable :  LatestCodable){
        for (currencySymbol, value) in latestCodeable.rates {
            currencyModelArray.append(CurrencyModel(currencySymbol: currencySymbol, name: currencyNameAndSymbols[currencySymbol] ?? "", value: value))
        }
        onFinishGetLatestCurrency?()
    }
    
    
    func getCurrencyListName() -> [String] {
        return currencyModelArray.map({$0.name})
    }
    
    
    func convertToCurrency(fromCurrency : String , toCurrency : String , value : Double ) -> Double {
        
        guard let fromCurrencyModel = currencyModelArray.filter({$0.currencySymbol == fromCurrency}).first else { return 0.0}
        guard let toCurrencyModel = currencyModelArray.filter({$0.currencySymbol == toCurrency}).first else { return 0.0}
        let answer = (toCurrencyModel.value *  value ) / Double(fromCurrencyModel.value )
        return answer
    }
    
    func getCurrencyId(fromName name : String) -> String {
        return  currencyModelArray.filter({$0.name == name}).first!.currencySymbol
    }
    
    func callLatestRateAPI() {
        
        onStartLoading?()

        repository.callFixerLatestAPI {[weak self] latestCodable in
            guard let self = self else { return }
            
            print(latestCodable)
            if latestCodable.success == true {
                self.saveLatestCodabeValue(latestCodable)
            }
        } failHandler: {[weak self] error in
            guard let self = self else { return }
            self.onFinishWithError?(error?.localizedDescription ?? "Something wrong")
        }
        
    }
}
