//
//  NetworkErrors.swift
//  FetchTestAssignment
//
//  Created by саргашкаева on 26.04.2023.
//

import Foundation


enum NetworkError: Error {
    case notFound
    case unauthorized
    case forbidden
    case decodingError
    case badRequest
}
