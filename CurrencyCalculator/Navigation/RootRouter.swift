//
//  RootRouter.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 10.01.2023.
//

import UIKit

final class RootRouter {

    private let window: UIWindow
    private var rootViewController: UIViewController
    private let sceneFactory: SceneFactoryProtocol

    init(window: UIWindow) {
        self.window = window
        self.rootViewController = .init()
        
        sceneFactory = SceneFactory()
    }
    
    func showMainViewController() {
        rootViewController = sceneFactory.createConverterVC(router: self)
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func showCurrencyList(_ completion: ((String) -> Void)? = nil) {
        let viewController = sceneFactory.createCurrencyListVC(router: self, completion: completion)
        rootViewController.present(viewController, animated: true)
    }

    func dismiss(_ viewController: UIViewController?) {
        if let viewController = viewController {
            viewController.dismiss(animated: true)
        }
    }

    func showOKAlert(over viewController: UIViewController?,
                     for error: String) {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                self.showOKAlert(over: viewController, for: error)
            }
            return
        }
        let alert = UIAlertController(title: "Error",
                                      message: error,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default))

        viewController?.present(alert, animated: true)
    }

}
