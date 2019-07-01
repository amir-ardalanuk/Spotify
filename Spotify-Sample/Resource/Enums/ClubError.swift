//
//  PatoghiError.swift
//  Patoghi Driver
//
//  Created by Farhad Faramarzi on 4/30/18.
//  Copyright © 2018 Golrang. All rights reserved.
//

import Foundation

enum SpotifyError: LocalizedError {
    
    case failure(message: String)
    
    var localization: String {
        switch self {
        case .failure(let message):
            return message
        default: return "Error exeption"
        }
    }
}
