//
//  AlbumResponse.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper
class AlbumResponse :  Mappable{
    
    var href : String?
    var items : [Album]?
    var limit : Int?
    var next : String?
    var offset : Int?
    var previous : AnyObject?
    var total : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        href <- map["href"]
        items <- map["items"]
        limit <- map["limit"]
        next <- map["next"]
        offset <- map["offset"]
        previous <- map["previous"]
        total <- map["total"]
    }
}
