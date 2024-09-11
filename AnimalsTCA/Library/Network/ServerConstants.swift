//
//  ServerConstants.swift
//  AnimalsTCA
//
//  Created by Serhii Kostiuk  on 11.09.2024.
//

import Foundation

enum ServerConstants {
    static var serverURL: String {
        "https://raw.githubusercontent.com/"
    }
    
    enum Path {
        static var filePath: String {
            "AppSci/promova-test-task-iOS/main/"
        }
    }
    
    static var fileName: String {
        "animals.json"
    }
}
