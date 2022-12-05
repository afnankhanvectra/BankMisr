//
//  Repository.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

typealias GenericResult<T> = (Result<T, Error>) -> Void

protocol RepositoryProtocol {
    
    func callFixerLatestAPI(successHandler: @escaping ((LatestCodable) -> Void),
                            failHandler: @escaping ((BMError?) -> Void))
    
    func callFixerTimeSeriesAPI(targetedCurrencies: String, successHandler: @escaping ((HistoricalRecordCodable) -> Void),
                                failHandler: @escaping ((BMError?) -> Void))
}

class Repository: RepositoryProtocol {
    
    static let shared = Repository()
    
    private init() { }
    
    func callFixerLatestAPI(successHandler: @escaping ((LatestCodable) -> Void),
                            failHandler: @escaping ((BMError?) -> Void)) {
        
        let apiRequest = ApiCall<LatestCodable>(url: URLCreator.getLatestRates(), successHandler: {  (latestCodable: LatestCodable) -> Void  in
            successHandler(latestCodable)
            
        }) { (httpStatusCode: HttpStatusCode, errorMessage: BMError?) in
            failHandler(errorMessage)
        }
        apiRequest.callAPI()
    }
    
    
    func callFixerTimeSeriesAPI(targetedCurrencies: String, successHandler: @escaping ((HistoricalRecordCodable) -> Void),
                                failHandler: @escaping ((BMError?) -> Void)) {
        
        let apiRequest = ApiCall<HistoricalRecordCodable>(url: URLCreator.getHistoricalRecord(symbols: targetedCurrencies), successHandler: {  (historicalRecordCodable: HistoricalRecordCodable) -> Void  in
            successHandler(historicalRecordCodable)
            
        }) { (httpStatusCode: HttpStatusCode, errorMessage: BMError?) in
            failHandler(errorMessage)
        }
        apiRequest.callAPI()
    }
}
