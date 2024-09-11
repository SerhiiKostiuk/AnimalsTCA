//
//  BaseRequestProtocol.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import Alamofire

protocol BaseRequestProtocol: URLRequestConvertible {
    var method: HTTPMethod { get }
    var serverURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

extension BaseRequestProtocol {
    
    func url() throws -> URL {
        let url = try self.serverURL.asURL()
        return url.appending(path: self.path)
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    func asURLRequest() throws -> URLRequest {
        do {
            let url = try self.url()
            var urlRequest = URLRequest(url: url)
            urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
            
            urlRequest.httpMethod = self.method.rawValue
        
            return urlRequest
        } catch {
            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
        }
    }
}
