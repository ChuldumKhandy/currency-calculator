//
//  CurrencyListPresenter.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import Foundation

final class CurrencyListPresenter {
    
    private weak var router: RootRouter?
    private weak var view: CurrencyListViewController?
    private let networkService = CurrencyListNetworkService()
    private var pairs: [String]
    
    var updateCallback: ((String) -> Void)?
    
    init(router: RootRouter) {
        self.router = router
        pairs = CacheManager.shared.load(from: RepositoryName.currencyList.rawValue) ?? []
        loadCurrencies()
    }
    
    var pairCount: Int {
        pairs.count
    }
    
    func loadView(view: CurrencyListViewController) {
        self.view = view
    }
    
    func getPair(by index: Int) -> String {
        return pairs[index]
    }
    
    func selectPair(by index: Int) {
        let pair = pairs[index]
        updateCallback?(pair)
        dismiss()
    }
    
    func dismiss() {
        router?.dismiss(view)
    }
    
    private func loadCurrencies() {
        guard pairs.isEmpty else {
            view?.reloadData()
            return
        }
        
        networkService.getList { result in
            switch result {
            case .success(let pairs):
                self.pairs = pairs
                CacheManager.shared.save(self.pairs, to: RepositoryName.currencyList.rawValue)
                self.view?.reloadData()
            case .failure(let error):
                self.router?.showOKAlert(over: self.view,
                                         for: error.localizedDescription)
            }
        }
    }
}
