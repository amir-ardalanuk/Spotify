//
//  Route.swift
//  ICRM-Customer
//
//  Created by Amir ARdalam
//  Copyright © 2017 Amir Ardi. All rights reserved.
//

import Foundation

let baseUrl = "https://api.spotify.com/v1/"
//let baseUrl = "https://crmretail-api.gig.services" //Develope
//gtarabar-api.gig.services

enum Route: String {
    case search = "search"
}

extension Route {
    
    var url : String {
        return baseUrl + "\(self.rawValue)"
    }
}






