//
//  BaseRouter.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation



protocol BaseRouter {
    var path: String { get }
    var method: HttpMethod { get }
    var queryParameter: [URLQueryItem]? { get }
    var httpBody: Data? { get }
    var httpHeader: [HttpHeader]? { get }
}


extension BaseRouter {
    var host: String {
        return "themealdb.com"
    }
    
    var scheme: String {
        return "https"
    }
    
    func createURLRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = queryParameter
        
        guard let url = urlComponents.url else {
            fatalError(URLError(.unsupportedURL).localizedDescription)
        }
        print(url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = httpBody
        httpHeader?.forEach({ header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.field)
        })
        return urlRequest
    }
}
