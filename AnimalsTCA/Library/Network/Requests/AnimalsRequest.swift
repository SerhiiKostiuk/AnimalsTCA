//
//  AnimalsRequest.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation
import Alamofire
enum AnimalsRequest: BaseRequestProtocol {
    
    case animalsCategories
  
    // MARK: - Properties
    // MARK: Public
    
    var method: HTTPMethod {
        .get
    }
    
    var serverURL: String {
        ServerConstants.serverURL
    }
    
    var path: String {
        switch self {
        case .animalsCategories:
            return ServerConstants.Path.filePath + ServerConstants.fileName
        }
    }
}
