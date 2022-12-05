//
//  HistoricalRecordCodable.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import Foundation


struct HistoricalRecordCodable: Codable {
    
    let base :      String
    let start_date :      String
    let end_date :      String
    let timeseries :   Bool
    let success :   Bool
    let rates :     [String : [String : Double]]
    
}
