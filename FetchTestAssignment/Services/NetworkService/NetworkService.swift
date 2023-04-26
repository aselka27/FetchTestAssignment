//
//  NetworkService.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


class NetworkService {
    
    let mainQueue = DispatchQueue.main
    
    func performFetch<T: Decodable>(urlRequest: URLRequest, decodedModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
