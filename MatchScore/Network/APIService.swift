//
//  APIService.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

import Combine

protocol APIServiceContract {
    func request<T: Decodable>(request: PSRequest, expecting type: T.Type) -> Future<[T], Error>
}

class APIService {
    let session: URLSessionContract
    
    static let shared = APIService()
    
    private var cancellables = Set<AnyCancellable>()
    
    private var token: String {
        ProcessInfo.processInfo.environment["PANDA_SCORE_API"] ?? ""
    }
    
    init(session: URLSessionContract = URLSession.shared) {
        self.session = session
    }
}

extension APIService: APIServiceContract {
    
    func request<T: Decodable>(request: PSRequest, expecting type: T.Type) -> Future<[T], Error> {
        return Future { promise in
            guard let urlRequest = self.makeRequest(from: request) else {
                promise(.failure(PSRequestError.invalidURLRequest))
                return
            }
            
            let cancellable = self.session.dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw PSRequestError.responseError
                    }
                    
                    guard (200..<300).contains(httpResponse.statusCode) else {
                        throw PSRequestError.httpError(statusCode: httpResponse.statusCode)
                    }
                    
                    return data
                }
                .decode(type: [T].self, decoder: JSONDecoder())
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { value in
                    promise(.success(value))
                })
            
            cancellable.store(in: &self.cancellables)
        }
    }
    
    private func buildUrl(from request: PSRequest) -> String {
        var urlString = request.baseUrl
        
        if !request.pathComponents.isEmpty {
            request.pathComponents.forEach({
                urlString += "/\($0)"
            })
        }
        
        urlString += "/"
        urlString += request.endpoint.rawValue

        if !request.queryParameters.isEmpty {
            urlString += "?"
            let argumentString = request.queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")

            urlString += argumentString
        }
        
        return urlString
    }
    
    private func makeRequest(from psRequest: PSRequest) -> URLRequest? {
        let url = URL(string: buildUrl(from: psRequest))
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = psRequest.httpMethod.rawValue
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
}
