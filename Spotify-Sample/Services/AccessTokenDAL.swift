//
//  AccessTokenDAL.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
class AccessTokenDAL {
    
    private let _TOKEN_KEY = "acKey"
    static let shared = AccessTokenDAL()
    
    private init(){
        
    }
    
    func get()->String?{
        return UserDefaults.standard.string(forKey: _TOKEN_KEY)
    }
    
    func set(key : String){
        UserDefaults.standard.set(key, forKey: _TOKEN_KEY)
    }
}
