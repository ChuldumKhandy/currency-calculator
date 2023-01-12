//
//  ConverterPresenter.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import Foundation

final class ConverterPresenter {
    
    private weak var router: RootRouter?
    private weak var view: ConverterViewController?
    private let networkService = ConverterNetworkService()
    private var rates: [CurrencyPair]
    private var currentPair: CurrencyPair?
    
    init(router: RootRouter) {
        self.router = router
        rates = CacheManager.shared.load(from: RepositoryName.rates.rawValue) ?? []
    }
    
    func loadView(view: ConverterViewController) {
        self.view = view
    }
    
    func showCurrencyList() {
        self.router?.showCurrencyList({ pair in
            self.loadRate(for: pair)
        })
    }
    
    func converted(valueText: String?, isTopText: Bool = true) -> String? {
        guard let value = valueText?.asFloat,
              let rate = currentPair?.rate else {
            return nil
        }
        let result = isTopText ? rate * value : value / rate
        
        return result.asString
    }

    private func loadRate(for pair: String) {
        guard !rates.contains(where: { $0.name == pair }) else {
            updateData(pair: pair)
            return
        }
        
        networkService.getRates(pairs: pair) { result in
            switch result {
            case .success(let dictionary):
                let currentRate = dictionary.map { (key: String, value: AnyObject) in
                    CurrencyPair(name: key, rate: (value as? String)?.asFloat ?? 0)
                }
                self.rates += currentRate
                CacheManager.shared.save(self.rates, to: RepositoryName.rates.rawValue)
                self.updateData(pair: pair)
            case .failure(let error):
                self.router?.showOKAlert(over: self.view,
                                         for: error.localizedDescription)
            }
        }
    }
    
    private func updateData(pair: String) {
        currentPair = rates.first(where: { $0.name == pair })
        updateCurrency()
        updateValue()
    }
    
    private func updateCurrency() {
        guard let pair = currentPair?.name else {
            return
        }
        
        let top = String(pair.prefix(3))
        let bottom = String(pair.suffix(3))
        view?.updateCurrencyLabels(top: top, bottom: bottom)
    }
    
    private func updateValue() {
        let top = "1"
        let bottom = converted(valueText: top)
        view?.updateCurrencyValue(top: top, bottom: bottom)
    }
}
