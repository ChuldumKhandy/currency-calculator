//
//  SceneFactory.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 10.01.2023.
//

import Foundation

protocol SceneFactoryProtocol {
    func createConverterVC(router: RootRouter) -> ConverterViewController
    func createCurrencyListVC(router: RootRouter, completion: ((String) -> Void)?) -> CurrencyListViewController
}

final class SceneFactory: SceneFactoryProtocol {
    
    func createConverterVC(router: RootRouter) -> ConverterViewController {
        let viewController = ConverterViewController.loadFromNib()
        let presenter = ConverterPresenter(router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
    func createCurrencyListVC(router: RootRouter, completion: ((String) -> Void)?) -> CurrencyListViewController {
        let viewController = CurrencyListViewController.loadFromNib()
        let presenter = CurrencyListPresenter(router: router)
        presenter.updateCallback = completion
        viewController.presenter = presenter
        
        return viewController
    }
}
