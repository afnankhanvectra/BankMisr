//
//  CurrencyConverterViewModel.swift
//  BankMisr
//
//  Created by Afnan Khan on 30/11/2022.
//

import Foundation

class CurrencyConverterViewModel : BMBaseViewModel {
    
    private var currencyModelArray = [CurrencyModel]()
    
    private var historicalRecordModelArray = [HistoricalRecordModel]()
    
    var onFinishGetLatestCurrency: VoidCallBack?
    var onFinishGetHistoricalRecord: VoidCallBack?
    
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
    
    private func saveHistoryRatesRecord(_ historicalRecordCodable :  HistoricalRecordCodable){
        historicalRecordModelArray.removeAll()
        for (date, record) in historicalRecordCodable.rates {
            var structRecord = HistoricalRecordModel()
            structRecord.date = date
            for (currencySymbol, value) in record {
                structRecord.currencyValues.append((currencySymbol,value))
            }
            // For sorting record
            structRecord.currencyValues = structRecord.currencyValues.sorted(by: {$0.0 < $1.0})
            historicalRecordModelArray.append(structRecord)
        }
        historicalRecordModelArray = historicalRecordModelArray.sorted(by: {$0.date > $1.date})
        onFinishGetHistoricalRecord?()
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
    
    func getCurrencyName(fromSymbol symbol : String) -> String {
        return  currencyModelArray.filter({$0.currencySymbol == symbol}).first!.name
    }
    
    func getNumberOfDaysRecord() -> Int {
        return  historicalRecordModelArray.count
    }
    
    func getHistoricalRecord(ofIndex index : Int) -> HistoricalRecordModel? {
        return historicalRecordModelArray.count > index ?  historicalRecordModelArray[index] :  nil
    }
    
    //MARK: - API calls
    
    func callLatestRateAPI() {
        onStartLoading?()
        repository.callFixerLatestAPI {[weak self] latestCodable in
            guard let self = self else { return }
            if latestCodable.success == true {
                self.saveLatestCodabeValue(latestCodable)
            } else {
                self.onFinishWithError?(FGENERAL_ERROR)
            }
        } failHandler: {[weak self] error in
            guard let self = self else { return }
            self.onFinishWithError?(error?.localizedDescription ?? FGENERAL_ERROR)
        }
    }
    
    func callTimeSeriesRateAPI(with targetCurrencies: String) {
        onStartLoading?()
        repository.callFixerTimeSeriesAPI(targetedCurrencies: targetCurrencies) {[weak self] historicalRecordCodable in
            guard let self = self else { return }
            if historicalRecordCodable.success == true {
                self.saveHistoryRatesRecord(historicalRecordCodable)
            } else {
                self.onFinishWithError?(FGENERAL_ERROR)
            }
        } failHandler: {[weak self] error in
            guard let self = self else { return }
            self.onFinishWithError?(error?.localizedDescription ?? FGENERAL_ERROR)
        }
    }
    
    
}
