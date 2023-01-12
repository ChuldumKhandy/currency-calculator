//
//  CacheManager.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 12.01.2023.
//

import Foundation

enum RepositoryName: String {
    case currencyList
    case rates
}

final class CacheManager {
    
    static let shared = CacheManager()

    func load<T: Decodable>(from repository: String) -> T? {
        guard let data = UserDefaults.standard.value(forKey: repository) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }

    func save<T: Encodable>(_ data: T, to repository: String) {
        guard let data = try? JSONEncoder().encode(data) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: repository)
    }
}
