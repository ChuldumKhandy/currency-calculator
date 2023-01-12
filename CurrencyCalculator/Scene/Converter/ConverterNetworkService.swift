//
//  ConverterNetworkService.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import Foundation

final class ConverterNetworkService: NSObject {

    func getRates(pairs: String,
                  completion: @escaping (Result<[String: AnyObject], Error>) -> Void) {
        guard let url = URL(string: NetworkConfiguration.urlRates + pairs + "&key=" + NetworkConfiguration.token) else {
            return
        }
        NetworkService.shared.request(to: url) { result in
            switch result {
            case .success(let dictionary):
                if let data = dictionary["data"] as? [String: AnyObject] {
                    completion(.success(data))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

