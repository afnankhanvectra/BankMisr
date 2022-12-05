//
//  ViewController.swift
//  BankMisr
//
//  Created by Afnan Khan on 30/11/2022.
//

import UIKit
import RxSwift
import RxCocoa
import DropDown
import RxGesture

class CurrencyConverterViewController: BMBaseViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var fromCurrencyView :  UIView!
    @IBOutlet weak var fromTextField :     UITextField!
    @IBOutlet weak var fromLabel :         UILabel!
    
    @IBOutlet weak var swapButton :        UIButton!
    
    @IBOutlet weak var toCurrencyView :    UIView!
    @IBOutlet weak var toTextField :       UITextField!
    @IBOutlet weak var toLabel :           UILabel!
    
    //MARK: - Variables

    private var currencyConverterViewModel: CurrencyConverterViewModel!
    
    let disposeBag =    DisposeBag()
    let fromDropDown =  DropDown()
    let toDropDown =    DropDown()
    
    var fromCurrency = FBASE_CURRENCY { didSet {
        self.fromLabel.text = fromCurrency
        if !(self.toTextField.text.isNilOrEmpty()) && Double(self.fromTextField.text!) != nil {
            let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: fromCurrency, toCurrency: toCurrency , value : Double(self.fromTextField.text!)!)
            self.toTextField.text = "\(answer.round(to: 2))"
        }
    }
        
    }
    var toCurrency = FBASE_CURRENCY { didSet {
        self.toLabel.text = toCurrency
        if !(self.toTextField.text.isNilOrEmpty()) && Double(self.toTextField.text!) != nil {
            let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: toCurrency, toCurrency: fromCurrency , value : Double(self.toTextField.text!)!)
            self.fromTextField.text = "\(answer.round(to: 2))"
        }
    } }
    
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Currency list"

        // Do any additional setup after loading the view.
        
        setTextFeildSubscriber()
        setCurrencyDropDown()
    }
    
    //MARK: - Layout set up

    private func setTextFeildSubscriber () {
        
        fromTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.fromTextField.text.isNilOrEmpty()) && Double(self.fromTextField.text!) != nil {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: fromCurrency, toCurrency: toCurrency , value : Double(self.fromTextField.text!)!)
                    self.toTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
        
        toTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.toTextField.text.isNilOrEmpty()) && Double(self.toTextField.text!) != nil {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: toCurrency, toCurrency: fromCurrency , value : Double(self.toTextField.text!)!)
                    self.fromTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
    }
    
    override func setupViewModelCallbacks() {
        
        currencyConverterViewModel =  CurrencyConverterViewModel(repository: Repository.shared)
        
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
        
        currencyConverterViewModel.callLatestRateAPI()
        
        currencyConverterViewModel.onFinishGetLatestCurrency = { [weak self]  in
            guard let self = self else { return }
            self.fromDropDown.dataSource = self.currencyConverterViewModel.getCurrencyListName()
            self.toDropDown.dataSource = self.currencyConverterViewModel.getCurrencyListName()
        }
    }
    
    //MARK: - Actions

    private func setCurrencyDropDown() {
        
        fromDropDown.anchorView = fromCurrencyView // UIView or UIBarButtonItem
        fromDropDown.dataSource = currencyConverterViewModel.getCurrencyListName()
        fromDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.fromCurrency = self.currencyConverterViewModel.getCurrencyId(fromName: item)
        }
        
        fromCurrencyView.rx.tapGesture()
            .when(.recognized) // This is important!
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.fromDropDown.show()
            })
            .disposed(by: disposeBag)
        
        toDropDown.anchorView = toCurrencyView // UIView or UIBarButtonItem
        toDropDown.dataSource = currencyConverterViewModel.getCurrencyListName()
        toDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let self = self else { return }
            self.toCurrency = self.currencyConverterViewModel.getCurrencyId(fromName: item)
        }
        
        toCurrencyView.rx.tapGesture()
            .when(.recognized) // This is important!
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.toDropDown.show()
            })
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func swapButtonTapped(_ sender: Any) {
        
        let swap = fromCurrency
        fromCurrency = toCurrency
        toCurrency = swap
    }
    
}
