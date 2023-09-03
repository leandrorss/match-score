//
//  DispatchQueueContract.swift
//  MatchScore
//
//  Created by Leandro Rodrigues on 03/09/23.
//

import Foundation

protocol DispatchQueueContract {
    func async(execute work: @escaping @convention(block) () -> Void)
}

extension DispatchQueue: DispatchQueueContract {
    func async(execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: .unspecified, flags: [], execute: work)
    }
}
