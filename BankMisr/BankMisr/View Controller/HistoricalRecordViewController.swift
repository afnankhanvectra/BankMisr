//
//  HistoricalRecordViewController.swift
//  BankMisr
//
//  Created by Afnan Khan on 05/12/2022.
//

import UIKit

class HistoricalRecordViewController: BMBaseViewController {

    //MARK: - IBOutlet

    @IBOutlet weak var tableView: UITableView!
    
    //TODO: Get from previous controller
    
    private var currencyConverterViewModel: CurrencyConverterViewModel!


    //MARK: - View controller life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func setupViewModelCallbacks() {
        currencyConverterViewModel =  CurrencyConverterViewModel(repository: Repository.shared)
        currencyConverterViewModel.callTimeSeriesRateAPI()
        
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

    }
}


//MARK: - tableView Delegates

extension HistoricalRecordViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       // return currencyConverterViewModel.selectReloadCardListCount()
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = HistoricalRecordRowCell.dequeue(tableView, indexPath: indexPath)
      //  cell.setContents(currencyConverterViewModel, cardIndex: indexPath.row)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}
