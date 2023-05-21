//
//  NetworkService.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation



protocol NetworkServiceProtocol {
    func performFetch<T: Decodable>(urlRequest: URLRequest) async throws -> T
}


class MockNetworkService: NetworkServiceProtocol {
    lazy var meal = Meal(strMeal: "cake", strMealThumb: "", idMeal: "1")
    lazy var mockMealsResponse: MealsResponse = MealsResponse(meals: Array(repeating: meal, count: 10))
    func performFetch<T>(urlRequest: URLRequest) async throws -> T where T : Decodable {
        return mockMealsResponse as! T
    }
}

final class NetworkService: NetworkServiceProtocol {
    
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
            } else {
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    func performFetch<T: Decodable>(urlRequest: URLRequest) async throws -> T {
        try await withCheckedThrowingContinuation { continuation in
            self.performFetch(urlRequest: urlRequest, decodedModel: T.self) { result in
                continuation.resume(with: result)
            }
        }
       
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
    
    private func validateError(_ response: URLResponse?) -> Error? {
        guard let httpResponse = response as? HTTPURLResponse else {
            return URLError(.badServerResponse)
        }
        switch httpResponse.statusCode {
        case 200...210:
            return nil
        case 400:
            return NetworkError.badRequest
        default:
            return nil
        }
    }
}
