//
//  Date+Extension.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import Foundation

extension Date {
    
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        formatter.dateFormat = format
        let myStringafd = formatter.string(from: yourDate ?? Date())
        return myStringafd
    }
    
    func getDate(withGap gap : Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: gap, to: self)!
       }
    
}
