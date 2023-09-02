//
//  PSImageLoader.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 02/09/23.
//

import Foundation
import Combine

final class PSImageLoader {
    static let shared = PSImageLoader()

    private var imageDataCache = NSCache<NSString, NSData>()

    init() {}

    /// Get image content with URL
    /// - Parameter url: Source url
    /// - Returns: A publisher that emits a `Data` object or an error
    public func downloadImage(_ url: URL) -> AnyPublisher<Data, Error> {
        let key = url.absoluteString as NSString
        if let data = imageDataCache.object(forKey: key) as Data? {
            return Just(data)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .handleEvents(receiveOutput: { [weak self] data in
                self?.imageDataCache.setObject(data as NSData, forKey: key)
            })
            .eraseToAnyPublisher()
    }
}
