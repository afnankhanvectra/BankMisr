//
//  ViewController.swift
//  BankMisr
//
//  Created by Afnan Khan on 30/11/2022.
//

import UIKit
import RxSwift
import RxCocoa


class CurrencyConverterViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var fromButton :     UIButton!
    @IBOutlet weak var toButton :       UIButton!
    @IBOutlet weak var swapButton :     UIButton!
    @IBOutlet weak var fromTextField :  UITextField!
    @IBOutlet weak var toTextField :    UITextField!
    
    private var currencyConverterViewModel: CurrencyConverterViewModel!
    
    let disposeBag = DisposeBag()
    
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.currencyConverterViewModel =  CurrencyConverterViewModel()
        
        fromTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.fromTextField.text.isNilOrEmpty()) {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: 1, toCurrency: 2 , value : Double(self.fromTextField.text!)!)
                    self.toTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
        
        toTextField.rx.controlEvent([.editingChanged])
            .asObservable().subscribe({ [unowned self] _ in
                if !(self.toTextField.text.isNilOrEmpty()) {
                    let answer = self.currencyConverterViewModel.convertToCurrency(fromCurrency: 2, toCurrency: 1 , value : Double(self.toTextField.text!)!)
                    self.fromTextField.text = "\(answer.round(to: 2))"
                }
            }).disposed(by: disposeBag)
        
    }
}
