//
//  Const.swift
//  BankMisr
//
//  Created by Afnan Khan on 02/12/2022.
//

import Foundation


enum timeout: Double {
    case  short  =  5.0,
    medium  =  10.0,
    longer  =  15.0
}

public let FGET =                               "GET"
public let FPOST =                              "POST"
public let  FTOKEN_HEADER      =                 "apikey"
typealias VoidCallBack = (() -> Void)


let currencyNameAndSymbols = [
    "AUD" : "Australia Dollar",
    "BRL" : "Brazil Real",
    "CAD" : "Canada Dollar",
    "CNY" : "China Yuan Renminbi",
    "DKK" : "Denmark Krone",
    "EGP" : "Egypt Pound",
    "EUR" : "Euro Member Countries",
    "HKD" : "Hong Kong Dollar",
    "HUF" : "Hungary Forint",
    "INR" : "India Rupee",
    "IDR" : "Indonesia Rupiah",
    "IRR" : "Iran Rial",
    "ILS" : "Israel Shekel",
    "JPY" : "Japan Yen",
    "KPW" : "Korea (North) Won",
    "KRW" : "Korea (South) Won",
    "KGS" : "Kyrgyzstan Som",
    "LBP" : "Lebanon Pound",
    "LRD" : "Liberia Dollar",
    "MYR" : "Malaysia Ringgit",
    "MXN" : "Mexico Peso",
    "NZD" : "New Zealand Dollar",
    "USD" : "United States Dollar",

]

public let  FBASE_CURRENCY      =     "USD"

