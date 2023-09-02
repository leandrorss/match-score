//
//  PSRequest.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

struct PSRequest {
    
    let baseUrl = "https://api.pandascore.co"
    
    let endpoint: PSEndpoint
    
    let pathComponents: [String]
    
    let queryParameters: [URLQueryItem]
    
    let httpMethod: HTTPMethod = .get
    
    /// Construct Request
    /// - Parameters:
    ///   - endpoint: Target endpoint
    ///   - pathComponents: path collection
    ///   - queryParameters: query parameters
    public init(
        endpoint: PSEndpoint,
        pathComponents: [String] = [],
        queryParameters: [URLQueryItem] = []
    ) {
        self.endpoint = endpoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}

enum PSRequestError: Error {
    case failedToCreateURLRequest
    case invalidURLRequest
    case responseError
    case httpError(statusCode: Int)
    case unknown
}
