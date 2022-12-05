//
//  HistoricalRecordHeaderCell.swift
//  BankMisr
//
//  Created by Afnan Khan on 06/12/2022.
//

import UIKit

class HistoricalRecordHeaderCell: UITableViewCell, CellProvider {
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setContents(_ data: CurrencyConverterViewModel, recordIndex: Int) {
        guard let record = data.getHistoricalRecord(ofIndex: recordIndex) else { return }
        dateLabel.text = record.date
    }
}
