//
//  NetworkService.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
    func request<T: Decodable>(_ urlRequest: URLRequestConvertible, _ type: T.Type) async throws -> T
}

final class NetworkService {
    
}
