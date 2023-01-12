//
//  AppDelegate.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 10.01.2023.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private var router: RootRouter?
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            router = RootRouter(window: window)
            router?.showMainViewController()
        }
        
        return true
    }
}
