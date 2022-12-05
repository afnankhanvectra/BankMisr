//
//  HistoricalRecordRowCell.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import UIKit

class HistoricalRecordRowCell: UITableViewCell, CellProvider {

    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var currencyValue : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setContents(_ data: CurrencyConverterViewModel, recordIndex: IndexPath) {
        
        guard let record = data.getHistoricalRecord(ofIndex: recordIndex.section) else { return }
        // To handle if both currencies are equal
        if record.currencyValues.count > recordIndex.row {
        currencySymbol.text = record.currencyValues[recordIndex.row].0
        currencyValue.text = "\(record.currencyValues[recordIndex.row].1)"
        currencyName.text = data.getCurrencyName(fromSymbol: record.currencyValues[recordIndex.row].0)
        }
    }

}
