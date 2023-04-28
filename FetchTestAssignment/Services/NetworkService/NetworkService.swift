//
//  NetworkService.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


final class NetworkService {
    
    static let shared = NetworkService()
    
    private init() {}
    
    func performFetch<T: Decodable>(urlRequest: URLRequest, decodedModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        let mainQueue = DispatchQueue.main
        
        URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, error == nil else {
                completion(.failure(error!))
                return
            }
            if let successModel = self?.decodeData(data: data, decodableType: T.self) {
               mainQueue.async {
                    completion(.success(successModel))
                }
            }
        }.resume()
    }
}


extension NetworkService {
    private func decodeData<T: Decodable>(data: Data?, decodableType: T.Type) -> T? {
        guard let data = data else {
            return nil
        }
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
            return nil
        }
    }
}
