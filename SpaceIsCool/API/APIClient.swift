//
//  APIClient.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 19/07/2024.
//

import Foundation

final class APIClient: APIClientProtocol {
    private let urlSession: URLSession
    private let decoder: JSONDecoder
    
    init(
        urlSession: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.urlSession = urlSession
        self.decoder = decoder
    }
    
    func perform<T: Codable>(
        _ request: RequestProtocol
    ) async throws -> T {
        let (data, response) = try await urlSession.data(for: request.createURLRequest())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidServerResponse
        }
        return try decoder.decode(T.self, from: data)
    }
}

#if DEBUG

final class MockAPIClient: APIClientProtocol {
    private let data: Data
    
    init(data: Data) {
        self.data = data
    }
    
    func perform<T: Codable>(
        _ request: RequestProtocol
    ) async throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

#endif
