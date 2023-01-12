//
//  NetworkService.swift
//  CurrencyCalculator
//
//  Created by Хандымаа Чульдум on 11.01.2023.
//

import Foundation

struct NetworkConfiguration {
    static let urlList = "https://currate.ru/api/?get=currency_list&key="
    static let urlRates = "https://currate.ru/api/?get=rates&pairs="
    static let token = "2e5d955f4c52fb53bd73f0352d19c9a1"
}

enum ErrorResponse: String, Error {
    case noData
    case parse
}

final class NetworkService {
    
    static let shared = NetworkService()
    
    func request(to url: URL, completion: @escaping (Result<[String: Any], Error>) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        URLSession.shared.dataTask(with: urlRequest) { data, urlResponse, error in
            if let error = error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            guard let data = data,
                  let resultData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            else {
                DispatchQueue.main.async {
                    completion(.failure(ErrorResponse.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(resultData))
            }
        }.resume()
    }
    
}
