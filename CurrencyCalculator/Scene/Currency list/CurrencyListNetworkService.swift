//
//  CurrencyListNetworkService.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import Foundation

final class CurrencyListNetworkService {

    func getList(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = URL(string: NetworkConfiguration.urlList + NetworkConfiguration.token) else {
            return
        }
        NetworkService.shared.request(to: url) { result in
            
            switch result {
            case .success(let dictionary):
                if let data = dictionary["data"] as? NSArray {
                    let objCArray = NSMutableArray(array: data)
                    if let swiftArray = objCArray as NSArray as? [String] {
                        completion(.success(swiftArray))
                    }
                } else {
                    completion(.failure(ErrorResponse.parse))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

