//
//  URLCreator.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation

struct URLCreator {
    
    static internal func getBaseURL() -> URL {
        
        return  URL(string:APIRoutes.getConfig.baseURL )!
    }
    
    static internal func getTodo(todoNumber : String) -> URL {
        return  URL(string:APIRoutes.getConfig.baseURL  + "todos/" + todoNumber)!
    }

    static internal func getLatestRates() -> URL {
        return  URL(string:APIRoutes.getConfig.baseURL  + "latest?symbols=\(getCurrenciesSymbol())&base=\(FBASE_CURRENCY)")!
    }
    
    static internal func getHistoricalRecord(symbols: String) -> URL {
        return  URL(string:APIRoutes.getConfig.baseURL  + "timeseries?symbols=\(symbols)&start_date=\(Date().getDate(withGap: -FHISTORICAL_RECORD_DAYS).toString())&end_date=\(Date().toString())&base=\(FBASE_CURRENCY)")!
    }
    
    static private func getCurrenciesSymbol() -> String {
       return currencyNameAndSymbols.map{$0.key}.joined(separator: ",")
    }
    
    
}
