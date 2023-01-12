//
//  ConverterViewController.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 10.01.2023.
//

import UIKit

final class ConverterViewController: UIViewController {
    
    @IBOutlet private weak var topCurrencyLabel: UILabel!
    @IBOutlet private weak var topValueTextField: UITextField!
    @IBOutlet private weak var bottomCurrencyLabel: UILabel!
    @IBOutlet private weak var bottomValueTextField: UITextField!
    
    var presenter: ConverterPresenter?
    
    var changeCurrencyHandler: (() -> Void)?
    
    override func loadView() {
        super.loadView()
        presenter?.loadView(view: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onKeyboardApper),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
    }
    
    private func setup() {
        topValueTextField.keyboardType = .numberPad
        bottomValueTextField.keyboardType = .numberPad
        
        topValueTextField.addTarget(self,
                                    action: #selector(topTextFieldTextChanged(_:)),
                                    for: .editingChanged)
        bottomValueTextField.addTarget(self,
                                       action: #selector(bottomTextFieldTextChanged(_:)),
                                       for: .editingChanged)
    }

    func updateCurrencyLabels(top: String, bottom: String) {
        DispatchQueue.main.async {
            self.topCurrencyLabel.text = top
            self.bottomCurrencyLabel.text = bottom
        }
    }
    
    func updateCurrencyValue(top: String?, bottom: String?) {
        DispatchQueue.main.async {
            self.topValueTextField.text = top
            self.bottomValueTextField.text = bottom
        }
    }
    
    @objc
    private func onKeyboardApper() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func topTextFieldTextChanged(_ textField: UITextField) {
        bottomValueTextField.text = presenter?.converted(valueText: textField.text)
    }
    
    @objc
    func bottomTextFieldTextChanged(_ textField: UITextField) {
        topValueTextField.text = presenter?.converted(valueText: textField.text,
                                                      isTopText: false)
    }
    
    @objc
    private func dismissKeyboard() {
        guard let gestureRecognizers = self.view.gestureRecognizers else {
            return
        }
        gestureRecognizers.forEach {
            $0.isEnabled = false
        }
        self.view.endEditing(true)
    }
    
    @IBAction private func tappedChangeCurrencyButton(_ sender: Any) {
        presenter?.showCurrencyList()
    }
}
