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

class CurrencyConverterViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var fromCurrencyView : UIView!
    @IBOutlet weak var toButton :       UIButton!
    @IBOutlet weak var swapButton :     UIButton!
    @IBOutlet weak var fromTextField :  UITextField!
    @IBOutlet weak var toTextField :    UITextField!
    
    private var currencyConverterViewModel: CurrencyConverterViewModel!
    
    let disposeBag = DisposeBag()
    let fromDropDown = DropDown()
    let toDropDown = DropDown()
    
    var fromCurrency = "USD"
    var toCurrency = "USD"
    
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupViewModelCallbacks()
        
        setCurrencyDropDown()
        
        fromTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.fromTextField.text.isNilOrEmpty()) {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: fromCurrency, toCurrency: toCurrency , value : Double(self.fromTextField.text!)!)
                    self.toTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
        
        toTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.toTextField.text.isNilOrEmpty()) {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: toCurrency, toCurrency: fromCurrency , value : Double(self.toTextField.text!)!)
                    self.fromTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
        
    }
    
    func setupViewModelCallbacks() {
        
        self.currencyConverterViewModel =  CurrencyConverterViewModel(repository: Repository.shared)
        self.currencyConverterViewModel.callLatestRateAPI()
        
        currencyConverterViewModel.onFinishGetLatestCurrency = { [weak self]  in
            guard let self = self else { return }
            print("In Cal back ")
            self.fromDropDown.dataSource = self.currencyConverterViewModel.getCurrencyListName()
            self.fromCurrency = "USD"
            self.toCurrency = "USD"
            
        }
    }
    
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
        
    }
    
}
