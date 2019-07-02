//
//  SearchParam.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper

struct SearchParam : Mappable {
  
    
    enum SearchType :String{
        case artist = "artist"
        case track = "track"
    }
    var type : SearchType!
    var query : String?
    
    init?(map: Map) {
        
    }
    
    init(type : SearchType ,query:String? ) {
        self.type = type
        self.query = query
    }
    
    mutating func mapping(map: Map) {
        type <- map["type"]
        query <- map["q"]
    }
}
