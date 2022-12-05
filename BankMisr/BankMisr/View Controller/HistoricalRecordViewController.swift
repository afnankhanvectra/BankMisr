//
//  HistoricalRecordViewController.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import UIKit

class HistoricalRecordViewController: BMBaseViewController  {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    var currencyConverterViewModel: CurrencyConverterViewModel!
    var targetdCurrencies: String!
    
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Historical Record"
        
        
        // Do any additional setup after loading the view.
    }
    override func setupViewModelCallbacks() {
        
        currencyConverterViewModel.onStartLoading = { [weak self]  in
            guard let self = self else { return }
            self.showLoadingIndicator()
        }
        
        currencyConverterViewModel.onFinishWithError = {  [weak self]  message  in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingIndicator()
                self.showAlert(message: message)
            }
        }
        
        currencyConverterViewModel.onFinishGetHistoricalRecord = {  [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.dismissLoadingIndicator()
                self.tableView.reloadData()
            }
        }
        
        currencyConverterViewModel.callTimeSeriesRateAPI(with: targetdCurrencies)
        
    }
}


//MARK: - tableView Delegates

extension HistoricalRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return currencyConverterViewModel.getNumberOfDaysRecord()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HistoricalRecordRowCell.dequeue(tableView, indexPath: indexPath)
        cell.setContents(currencyConverterViewModel, recordIndex: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HistoricalRecordHeaderCell") as! HistoricalRecordHeaderCell
        headerCell.setContents(currencyConverterViewModel, recordIndex: section)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


extension HistoricalRecordViewController: ViewControllerProvider {
    static func storyboard() -> String {
        return "Main"
    }
}
