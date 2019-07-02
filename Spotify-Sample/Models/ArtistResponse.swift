//  ArtistResponse.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//ˆ

import Foundation
import ObjectMapper


class ArtistResponse : Mappable{
    
    var href : String?
    var items : [ArtistItem]?
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

class ArtistItem : Mappable{
    
    var externalUrls : ExternalUrl?
    var followers : Follower?
    var genres : [String]?
    var href : String?
    var id : String?
    var images : [ImageModel]?
    var name : String?
    var popularity : Int?
    var type : String?
    var uri : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        externalUrls <- map["external_urls"]
        followers <- map["followers"]
        genres <- map["genres"]
        href <- map["href"]
        id <- map["id"]
        images <- map["images"]
        name <- map["name"]
        popularity <- map["popularity"]
        type <- map["type"]
        uri <- map["uri"]
    }
}
class Follower : Mappable{
    
    var href : AnyObject?
    var total : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        href <- map["href"]
        total <- map["total"]
    }
}
class ExternalUrl :  Mappable{
    
    var spotify : String?
    
   
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        spotify <- map["spotify"]
    }
}
