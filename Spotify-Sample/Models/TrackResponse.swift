//
//  TrackResponse.swift
//  Spotify-Sample
//
//  Created by Amir Ardalan on 7/2/19.
//  Copyright © 2019 Amir Ardalani. All rights reserved.
//

import Foundation
import ObjectMapper


class TrackResponse : Mappable{
    
    var href : String?
    var items : [TrackItem]?
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
class TrackItem : Mappable{
    
    var album : Album?
    var artists : [ArtistItem]?
    var availableMarkets : [String]?
    var discNumber : Int?
    var durationMs : Int?
    var explicit : Bool?
    var externalIds : ExternalId?
    var externalUrls : ExternalUrl?
    var href : String?
    var id : String?
    var isLocal : Bool?
    var name : String?
    var popularity : Int?
    var previewUrl : AnyObject?
    var trackNumber : Int?
    var type : String?
    var uri : String?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        album <- map["album"]
        artists <- map["artists"]
        availableMarkets <- map["available_markets"]
        discNumber <- map["disc_number"]
        durationMs <- map["duration_ms"]
        explicit <- map["explicit"]
        externalIds <- map["external_ids"]
        externalUrls <- map["external_urls"]
        href <- map["href"]
        id <- map["id"]
        isLocal <- map["is_local"]
        name <- map["name"]
        popularity <- map["popularity"]
        previewUrl <- map["preview_url"]
        trackNumber <- map["track_number"]
        type <- map["type"]
        uri <- map["uri"]
    }
}
class ExternalId : Mappable{
    
    var isrc : String?

    required init?(map: Map){}
 
    
    func mapping(map: Map)
    {
        isrc <- map["isrc"]
    }
}
