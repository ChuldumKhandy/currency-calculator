//
//  Extensions.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import UIKit

extension UIViewController {
    
    static func loadFromNib() -> Self {
        func intantiateFromNib<T: UIViewController>() -> T {
            return T(nibName: String(describing: T.self), bundle: nil)
        }
        return intantiateFromNib()
    }
}

extension String {
    
    var asFloat: Float? {
        Float(self)
    }
}

extension Float {
    
    var asString: String {
        String(self)
    }
}
