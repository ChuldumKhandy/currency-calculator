//
//  SceneFactory.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 10.01.2023.
//

import Foundation

protocol SceneFactoryProtocol {
    func createConverterVC(router: RootRouter) -> ConverterViewController
}

final class SceneFactory: SceneFactoryProtocol {
    
    func createConverterVC(router: RootRouter) -> ConverterViewController {
        let viewController = ConverterViewController.loadFromNib()
        let presenter = ConverterPresenter(router: router)
        
        viewController.presenter = presenter
        
        return viewController
    }
    
}

