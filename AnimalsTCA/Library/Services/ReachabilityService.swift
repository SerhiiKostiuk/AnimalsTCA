//
//  ReachabilityService.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 13.09.2024.
//

import Foundation
import Reachability

final class ReachabilityService {
    //MARK: - Private Properties
    private let reachability: Reachability

    //MARK: - Initializers
    init() {
        reachability = try! Reachability()
    }

    //MARK: - Public Func
    func connectionAvailable() -> Bool {
        switch reachability.connection {
        case .wifi, .cellular:
            return true
        case .unavailable:
            return false
        }
    }
}
