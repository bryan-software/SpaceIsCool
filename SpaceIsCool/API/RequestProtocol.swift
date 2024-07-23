//
//  RequestProtocol.swift
//  SpaceIsCool
//
//  Created by Dom Bryan on 19/07/2024.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    
    var urlParams: [String: String?] { get }
    
    var requestType: RequestType { get }
}

// Default implementation
extension RequestProtocol {
    var host: String {
        APIConstants.host
    }
    
    var params: [String: Any] {
        [:]
    }
    
    var urlParams: [String: String?] {
        [:]
    }
    
    var headers: [String: String] {
        [:]
    }
    
    func createURLRequest() throws -> URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        
        // Not ideal but basic auth for open API.
        // This would be passed as a auth header from an env variable in live app.
        components.queryItems = [URLQueryItem(name: "api_key", value: "ePqGvbeSV4zmINwznLze7IGacfs7bpfZYetfIPgb")]
        
        if !urlParams.isEmpty {
            urlParams.forEach {
                components.queryItems?.append(
                    URLQueryItem(name: $0, value: $1)
                )
            }
        }
        
        guard let url = components.url
        else { throw NetworkError.invalidURL }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        
        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: params
            )
        }
        
        return urlRequest
    }
}
