//
//  NetworkDispatcher.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 29/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

protocol NetworkDispatcherProtocol {
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkDispatcher: NetworkDispatcherProtocol {
    
    private let session = URLSession.shared
    
    func request(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = URL(string: url) else { return }
        session.dataTask(with: request) { (data, response, error) in
            if let fetchedData = data {
                completion(.success(fetchedData))
            } else {
                if let err = error {
                    completion(.failure(err))
                }
            }
        }.resume()
    }
}
