//
//  URLSessionContract.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation

protocol URLSessionContract {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

// MARK: - URLSession extension
extension URLSession: URLSessionContract { }
